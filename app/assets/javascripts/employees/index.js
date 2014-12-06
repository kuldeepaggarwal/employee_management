//= require flash_message

var Employees = Employees || {} ;
window.Employees.Index = function() {};

$.extend(Employees.Index.prototype, true, {
  init: function() {
    this._bindDeleteLinkClickEvent();
  },

  _bindDeleteLinkClickEvent: function() {
    $('.delete').click(function(event) {
      if(confirm('Are you sure, you want to delete?')) {
        var deleteLink = this;
        $.ajax({
          url: deleteLink.href,
          dataType: 'JSON',
          method: 'DELETE',
          beforeSend: function(xhr) {
            $.rails.CSRFProtection(xhr);
          }
        }).done(function(data) {
          FlashMessage.create('success', data.message);
          $(deleteLink).parents('tr').remove();
        }).fail(function(xhr, status, status_message) {
          FlashMessage.create('error', xhr.responseJSON.message);
        });
      }
      event.preventDefault();
    });
  }
});

window.Employees.index = (new window.Employees.Index());
$(function() { window.Employees.index.init(); });
