(function() {
  this._escape = function(str) {
    return str.replace(/&/g, '&amp;').replace(/>/g, '&gt;').replace(/</g, '&lt;').replace(/"/g, '&quot;');
  };

  this._unescape = function(str) {
    return str.replace(/&amp;/g, '&').replace(/&gt;/g, '>').replace(/&lt;/g, '<').replace(/&quot;/g, '"');
  };

  this.render_tree = function(tree, options) {
    var boost, children, children_html, elem, html, item, min_elem, node, num, opts, roots, _i, _j, _k, _l, _len, _len1, _len2, _len3, _len4, _m;
    if (options == null) {
      options = {};
    }
    html = '';
    opts = {
      id: 'id',
      node: null,
      root: false,
      level: 0,
      boost: []
    };
    $.extend(opts, options);
    if (opts['boost'].length !== 0) {
      boost = [];
      for (_i = 0, _len = tree.length; _i < _len; _i++) {
        node = tree[_i];
        num = node.parent_id || 0;
        item = boost[num];
        if (!(item instanceof Array)) {
          boost[num] = [];
        }
        boost[num].push(node);
      }
      opts['boost'] = boost;
    }
    if (!opts.node) {
      roots = opts['boost'][0];
      min_elem = tree[0];
      if (roots.length === 0 && tree.length !== 0) {
        for (_j = 0, _len1 = tree.length; _j < _len1; _j++) {
          elem = tree[_j];
          if (elem.parent_id < min_elem.parent_id) {
            min_elem = elem;
          }
        }
        for (_k = 0, _len2 = tree.length; _k < _len2; _k++) {
          elem = tree[_k];
          if (elem.parent_id === min_elem.parent_id) {
            roots.push(elem);
          }
        }
      }
      for (_l = 0, _len3 = roots.length; _l < _len3; _l++) {
        node = roots[_l];
        $.extend(opts, {
          node: node,
          root: false,
          level: opts.level + 1
        });
        children_html = render_tree(tree, opts);
        html += opts.render_node(node, children_html, opts);
      }
    } else {
      children = [];
      children_html = '';
      children = boost[opts.node.id];
      for (_m = 0, _len4 = children.length; _m < _len4; _m++) {
        node = children[_m];
        $.extend(opts, {
          node: node,
          root: false,
          level: opts.level + 1
        });
        children_html = render_tree(tree, opts);
        html += opts.render_node(node, children_html, opts);
      }
    }
    return html;
  };

}).call(this);
