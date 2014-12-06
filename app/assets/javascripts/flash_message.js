var FlashMessage = {
  create: function(type, message, targetDiv) {
    var targetDiv = targetDiv || $('.flash');
    targetDiv.html(this.generateHTML(type, message));
  },

  generateHTML: function(type, message) {
    var html = $("<button>", { "type": "button", "class": "close", "data-dismiss": "alert", "html": "&times;"})[0].outerHTML +
           $("<div>", { "class": 'alert alert-block', "style": "text-align:center;" })
            .addClass("alert-" + type)
            .html($("<p>").html(message))[0]
            .outerHTML
    return html;
  }
};
