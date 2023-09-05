// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require ../../../../../../.rbenv/versions/3.0.4/lib/ruby/gems/3.0.0/gems/actioncable-6.1.7.4/app/assets/javascripts/action_cable
//= require_self
//= require_tree ./channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);
