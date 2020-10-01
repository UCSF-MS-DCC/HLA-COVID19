class UploadController < ApplicationController
    require 'csv'
    before_action :authenticate_user!

    def index
        if !current_user || current_user.projects.count < 1
            redirect_to root_path
        end
        @user = current_user
        @projects = current_user.projects
    end

    def store 
        unless upload_params[:irb_sharing_approved] == false
            current_user.uploads.attach(upload_params[:attachments])
            current_user.upload_filename_check
        end
        # current_user.uploads.each do |u|
        #     puts "FILE: #{u.filename}"
        # end
        redirect_to action: "index"
    end
    # new method to replace 'store' - this will parse the csv, check for errors, and insert the contents into the database
    def import_data
        # for purposes of reporting errors, make these flags, writable to the upload_record table
        unless upload_params[:irb_sharing_approved] == false
            unless !current_user.uploads.attach(upload_params[:attachment]) 
                begin
                    # capture upload params for flow control and upload record creation
                    irb_approved = upload_params[:irb_sharing_approved]
                    csv_attached = upload_params[:attachment].size > 0
                    upload_project_name = upload_params[:project_name]
                    filename = current_user.uploads.order("created_at ASC").last.filename
                    upload_type = upload_params[:upload_type]
                    subjects_n = 0
                    puts upload_params.to_json

                    csv = CSV.parse(current_user.uploads.order("created_at ASC").last.download, headers: true)
                    # check csv format for column headers not conforming to the db schema
                    header_format_check = helpers.check_headers(csv.headers)
                    bad_columns = header_format_check[:bad_headers]
                    # if headers are ok and user has verified they can share data, proceed with parsing & insertion
                    if header_format_check[:form_ok] == true && irb_approved && Project.find_by(user_id:current_user.id, name:upload_project_name)
                        # iterate over the csv rows, extracting and inserting the data points
                        # flow control here for different upload types.
                        if upload_type == "new_subject"
                            csv.each do |row|
                                # if no project_name in csv, add to the user's project specified in the upload form 
                                if !row["project_name"] || !csv.headers.include?("project_name") || !current_user.projects.find_by(name:row["project_name"])
                                    @project = current_user.projects.find_by(name:upload_project_name)
                                else
                                    @project = current_user.projects.find_by(name:row["project_name"])
                                end
                                datapoints = helpers.parse_row(row)
                                subject = Subject.find_by(origin_identifier: datapoints[:subject]["origin_identifier"]) # need to guard against subjects with the same ids from being overwritten
                                if subject.nil?
                                    @subject = Subject.new(datapoints[:subject])
                                    @subject["project_id"] = @project.id
                                    if !@subject.project_id.nil? && @subject.save 
                                        subjects_n += 1
                                        helpers.build_relations(@subject, datapoints)
                                    else
                                    end
                                    #log result of save attempt to log file
                                else
                                    # subject.update_attributes(datapoints[:subject])
                                    # if errors from the update, capture on log file
                                end
                            end
                            UploadRecord.new(active_storage_attachment_id:current_user.uploads.order("created_at ASC").last.id, subjects:subjects_n,
                            csv_file:csv_attached, irb_approved_checkbox:irb_approved, upload_filename:filename, uploaded_by:current_user.email,
                            upload_type:upload_type, project:@project.name).save
                        # longitudinal data (c19 symptoms, labtests, hospitalizations(if they've been more than once)) can be added to existing patients
                        elsif upload_type == "long_data"
                            csv.each do |row|
                                datapoints = helpers.parse_row_longitudinal(row)
                                @subject = Subject.find_by(origin_identifier: datapoints[:subject]["origin_identifier"])
                                unless @subject.nil?
                                    helpers.build_relations(@subject, datapoints)
                                end
                            end
                            UploadRecord.new(active_storage_attachment_id:current_user.uploads.order("created_at ASC").last.id, subjects:subjects_n,
                            csv_file:csv_attached, irb_approved_checkbox:irb_approved, upload_filename:filename, uploaded_by:current_user.email,
                            upload_type:upload_type, project:@project.name).save
                        # elsif upload_type == "correction"
                        end
                        gflash :success => "Data upload successful"
                    # reject uploads that do not contain irb approval
                    elsif !irb_approved
                        UploadRecord.new(active_storage_attachment_id:current_user.uploads.order("created_at ASC").last.id, subjects:subjects_n,
                         bad_columns:bad_columns,csv_file:false, irb_approved_checkbox:irb_approved, upload_filename:filename,
                         uploaded_by:current_user.email,upload_type:upload_type).save
                         gflash :error => "Users must vouch that are approved to upload data to the database. Your file's data was not be added to the database."
                    # catchall for bad uploads 
                    else 
                        UploadRecord.new(active_storage_attachment_id:current_user.uploads.order("created_at ASC").last.id, subjects:subjects_n,
                         bad_columns:bad_columns,csv_file:csv_attached, irb_approved_checkbox:irb_approved, upload_filename:filename,
                         uploaded_by:current_user.email,upload_type:upload_type).save
                         gflash :warning => "There were problems uploading your file. Download the report for details."
                    end
                rescue CSV::MalformedCSVError  # notify users that their file is not a valid .csv
                    UploadRecord.new(active_storage_attachment_id:current_user.uploads.order("created_at ASC").last.id, subjects:subjects_n,
                         bad_columns:bad_columns,csv_file:false, irb_approved_checkbox:irb_approved, upload_filename:filename,
                         uploaded_by:current_user.email,upload_type:upload_type).save
                         gflash :error => "There was a problem with your upload file. Be sure to your file is a csv and conforms to the data upload template."

                end # close begin/rescue block

            end # close block check for attachment files
        end #close block check for irb approval
        redirect_to action: "index"

    end

    def get_report
        upload_record = UploadRecord.find(params[:upload_report_id])
        upload = ActiveStorageAttachment.find(upload_record.active_storage_attachment.id)
        #user = User.find_by(id:upload_record.active_storage_attachment.)
        file = Tempfile.new("HLAC19_tempfile_#{upload_record.created_at.strftime('%Y%m%d%H%M')}")
        file.write("User: #{upload_record.uploaded_by}\n")
        file.write("Filename: #{upload_record.upload_filename}\n")
        file.write("Project: #{upload_record.project}\n")
        file.write("Data depositing approved by IRB/ethics board? #{upload_record.irb_approved_checkbox}\n")
        file.write("Upload time: #{upload_record.created_at.strftime('%b %d, %Y %H:%M')}\n")
        file.write("Upload type: #{upload_record.upload_type}\n")
        file.write("Number of subjects uploaded: #{upload_record.subjects}\n")
        file.write("Incorrect column headers: #{upload_record.bad_columns} - (If list is not empty check the data dictionary for correct variable names).\n")
        file.rewind
        file.close
        respond_to do |format|
            format.text { send_file file.path, type: 'text/plain', filename:"HLA-COVID19_DATABASE_UPLOAD_REPORT_#{upload_record.created_at.strftime('%Y%m%d%H%M')}" }
        end
    end

    def download_template
        send_file "public/UploadResources/UploadTemplate.csv", type: 'text/csv'
    end

    def download_dictionary
        send_file "public/UploadResources/HLA_COVID19_data_dictionary.xlsx", type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    end

    private

    def upload_params
        params.require(:user).permit(:irb_sharing_approved, :attachment, :upload_type, :project_name)
    end

end