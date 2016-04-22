//= require_self
//= require dvl/core/styled_select
//= require dvl/core/styled_controls
//= require dvl/components/navbar
//= require dvl/components/flashes

var Dvl = {};

// Monkeypatch Selectize to not use "item" class, which conlflits with dvl-core...
var oldSetupTemplates = Selectize.prototype.setupTemplates;
Selectize.prototype.setupTemplates = function(){
  oldSetupTemplates.apply(this, arguments);
  this.settings.render.item = function(data, escape) {
    return '<div class="selectize-item">' + escape(data[this.settings.labelField]) + '</div>';
  }
}

$(function(){
  $('body').styledSelect()
  $('body').styledControls()
})
