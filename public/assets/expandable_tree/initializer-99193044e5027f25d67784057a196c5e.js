(function() {
  this.add_to_restorable_path = function(node) {
    var id;
    if (window.is_restorable_tree) {
      id = node.data('node-id');
      nested_tree_path_add(id);
      return true;
    }
    return false;
  };

  this.remove_from_restorable_path = function(node) {
    var id;
    if (window.is_restorable_tree) {
      id = node.data('node-id');
      nested_tree_path_remove(id);
      return true;
    }
    return false;
  };

  this.nested_tree_toggle = function(button) {
    if (button.hasClass('minus')) {
      return button.removeClass('minus').addClass('plus').html('+');
    } else {
      return button.removeClass('plus').addClass('minus').html('&ndash;');
    }
  };

  this.append_children_to_node = function(node, html) {
    var button, item;
    html = html.trim();
    item = node.children('.item');
    button = node.children('.item').children('.expand');
    if (html.length === 0) {
      button.addClass('empty');
    }
    if (html.length > 0) {
      item.after(html);
      nested_tree_toggle(button);
      return add_to_restorable_path(node);
    }
  };

  this.upload_nodes_children = function(node, expand_node_url) {
    var ctrl_items, node_id, tree;
    node_id = node.data('node-id');
    tree = $('.sortable_tree');
    ctrl_items = $('i.handle, b.expand', tree);
    return $.ajax({
      type: 'POST',
      dataType: 'html',
      data: {
        id: node_id
      },
      url: expand_node_url,
      beforeSend: function(xhr) {
        ctrl_items.hide();
        return window.skip_expandable_tree_hashchange = true;
      },
      success: function(data, status, xhr) {
        ctrl_items.show();
        return append_children_to_node(node, data);
      },
      error: function(xhr, status, error) {
        try {
          return console.log(error);
        } catch (_error) {}
      }
    });
  };

  this.init_expandable_tree = function() {
    var expand_node_url, sortable_tree, steps;
    sortable_tree = $('ol.sortable_tree');
    if (sortable_tree.length === 0) {
      return false;
    }
    window.is_restorable_tree || (window.is_restorable_tree = false);
    window.is_cookie_restoreable_tree = sortable_tree.data('cookie_store') || sortable_tree.data('cookie-store');
    if (window.is_cookie_restoreable_tree) {
      steps = $.cookie(TSTconst.cookie_name());
      if (steps) {
        _set_hash(TSTconst.hash_prefix() + steps);
      }
    }
    expand_node_url = sortable_tree.data('expand_node_url') || sortable_tree.data('expand-node-url');
    if (window.is_restorable_tree) {
      restore_nested_tree(sortable_tree, expand_node_url);
    }
    sortable_tree.on('click', '.expand.minus', function(e) {
      var button, node;
      button = $(this);
      node = button.parent().parent();
      nested_tree_toggle(button);
      remove_from_restorable_path(node);
      node.children('.nested_set').hide();
      return false;
    });
    sortable_tree.on('click', '.expand.plus', function(e) {
      var button, nested_set, node;
      button = $(this);
      node = button.parent().parent();
      nested_set = node.children('.nested_set');
      if (nested_set.length === 0) {
        upload_nodes_children(node, expand_node_url);
      } else {
        nested_set.show();
        nested_tree_toggle(button);
        add_to_restorable_path(node);
      }
      return false;
    });
    return true;
  };

  $(function() {
    return init_expandable_tree();
  });

}).call(this);
