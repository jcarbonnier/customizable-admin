/**
 * Trace messages in console
 * @param message
 */
var trace = function (message) {
    if (typeof (console) !== 'undefined' && console != null) {
        console.log(message);
    } else {
        // alert(message);
    }
}

/**
 * Add associated item inside container (has_many adding)
 * @param target
 * @param association
 * @param content
 */
function add_association(source, target, association, content) {
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g");
    var regexp2 = new RegExp("new_id", "g");
    trace($(source).closest(target));
    trace(content.replace(regexp, new_id).replace(regexp2, new_id));
    $(source).closest('fieldset,div').find(target).append(content/*.replace(regexp, new_id).replace(regexp2, new_id)*/);
}

/**
 * Remove associated item from container (has_many removing)
 * @param link
 * @param is_new_record
 * @param lang
 */
function remove_fields(link, is_new_record, lang) {
    if (is_new_record) {
        $(link).closest('.fields').remove();
    }
    else {
        var msg = (lang == 'fr') ? 'Vous êtes sur le point de supprimer une donnée. Sûr ?' : 'You\'re about to remove data. Are you sure ?';
        if (confirm(msg)) {
            $(link).prev('input[type=hidden]').val("true");
            var elem = $(link).closest('.fields');
            elem.hide();//.effect('fade', { duration: 300, direction: 'down' });
        }
    }
}

/**
 * Export list of items
 * @param f
 * @returns {boolean}
 */
function export_list(f) {
    window.open($(f).attr('action') + '.xls?per_page=1000000&' + $(f).serialize(), $(f).attr('name'));
    return false;
}
