(function() {
  this.rebuild_sortable_tree = function(rebuild_url, item_id, parent_id, prev_id, next_id) {
    return $.ajax({
      type: 'POST',
      dataType: 'script',
      url: rebuild_url,
      data: {
        id: item_id,
        parent_id: parent_id,
        prev_id: prev_id,
        next_id: next_id
      },
      beforeSend: function(xhr) {
        return $('.sortable_tree i.handle').hide();
      },
      success: function(data, status, xhr) {
        return $('.sortable_tree i.handle').show();
      },
      error: function(xhr, status, error) {
        return console.log(error);
      }
    });
  };

  this.init_sortable_tree = function() {
    var max_levels, rebuild_url, sortable_tree;
    sortable_tree = $('ol.sortable_tree');
    if (sortable_tree.length === 0) {
      return false;
    }
    rebuild_url = sortable_tree.data('rebuild_url') || sortable_tree.data('rebuild-url');
    max_levels = sortable_tree.data('max_levels') || sortable_tree.data('max-levels');
    sortable_tree.nestedSortable({
      items: 'li',
      helper: 'clone',
      handle: 'i.handle',
      tolerance: 'pointer',
      maxLevels: max_levels,
      revert: 250,
      tabSize: 25,
      opacity: 0.6,
      placeholder: 'placeholder',
      disableNesting: 'no-nest',
      toleranceElement: '> div',
      forcePlaceholderSize: true
    });
    sortable_tree.on("sortupdate", (function(_this) {
      return function(event, ui) {
        var attr_name, item, item_id, next_id, parent_id, prev_id;
        item = ui.item;
        attr_name = 'node-id';
        item_id = item.data(attr_name);
        prev_id = item.prev().data(attr_name);
        next_id = item.next().data(attr_name);
        parent_id = item.parent().parent().data(attr_name);
        return rebuild_sortable_tree(rebuild_url, item_id, parent_id, prev_id, next_id);
      };
    })(this));
    return true;
  };

  $(function() {
    return init_sortable_tree();
  });

}).call(this);
