(function() {
  window.is_restorable_tree = true;

  this.TSTconst = (function() {
    function TSTconst() {}

    TSTconst._name = 'TST';

    TSTconst.delimiter = ';';

    TSTconst.separator = '|';

    TSTconst.re = function() {
      return new RegExp(this.cookie_name() + '\\' + this.separator);
    };

    TSTconst.hash_prefix = function() {
      return this.cookie_name() + this.separator;
    };

    TSTconst.cookie_scope = function() {
      return $('.sortable_tree').data('cookie_scope') || $('.sortable_tree').data('cookie-scope');
    };

    TSTconst.cookie_name = function() {
      if (!this.cookie_scope()) {
        return this._name;
      }
      return this._name + '_' + this.cookie_scope();
    };

    return TSTconst;

  })();

  this._get_hash = function() {
    return document.location.hash;
  };

  this._set_hash = function(str) {
    window.skip_expandable_tree_hashchange = true;
    return document.location.hash = str;
  };

  this._uniqueArray = function(arr) {
    var item, key, output, val, _i, _len, _results;
    if (arr == null) {
      arr = [];
    }
    output = {};
    for (_i = 0, _len = arr.length; _i < _len; _i++) {
      item = arr[_i];
      output[item] = item;
    }
    _results = [];
    for (key in output) {
      val = output[key];
      _results.push(val);
    }
    return _results;
  };

  this._compactArray = function(array) {
    return array.filter(function(e) {
      return e;
    });
  };

  this._nested_set_hash_arr = function(hash) {
    var arr, prefix, _ref;
    if (!hash) {
      return [];
    }
    _ref = hash.split(TSTconst.separator), prefix = _ref[0], arr = _ref[1];
    return _compactArray(_uniqueArray(arr.split(TSTconst.delimiter)));
  };

  this.nested_tree_get_path = function() {
    var hash;
    hash = _get_hash();
    if (!hash.match(TSTconst.re())) {
      return false;
    }
    return _nested_set_hash_arr(hash);
  };

  this.hash_and_cookie_accordance = function() {
    var hash, str;
    if (window.is_cookie_restoreable_tree) {
      hash = _get_hash();
      if (hash.length === 0) {
        $.removeCookie(TSTconst.cookie_name());
      } else {
        if (!hash.match(TSTconst.re())) {
          return false;
        }
        str = hash.split(TSTconst.separator)[1];
        $.cookie(TSTconst.cookie_name(), str, {
          expires: 14
        });
      }
    }
    return false;
  };

  this.nested_tree_path_remove = function(id) {
    var arr, hash, index, str;
    hash = _get_hash();
    if (!hash.match(TSTconst.re())) {
      return false;
    }
    arr = _nested_set_hash_arr(hash);
    index = arr.indexOf(id + '');
    if (index === -1) {
      return hash_and_cookie_accordance();
    }
    arr.splice(index, 1);
    str = _uniqueArray(arr).join(TSTconst.delimiter);
    if (str.length === 0) {
      _set_hash('');
    } else {
      _set_hash(TSTconst.hash_prefix() + str);
    }
    hash_and_cookie_accordance();
    return true;
  };

  this.nested_tree_path_add = function(id) {
    var arr, hash, str;
    str = id;
    hash = _get_hash();
    if (hash.match(TSTconst.re())) {
      arr = _nested_set_hash_arr(hash);
      arr.push(id);
      arr = _uniqueArray(arr);
      str = arr.join(TSTconst.delimiter);
    }
    _set_hash(TSTconst.hash_prefix() + str);
    return hash_and_cookie_accordance();
  };

  this.load_nested_nodes = function(arr, expand_node_url) {
    var ctrl_items, id, node, tree;
    if (arr.length === 0) {
      window.skip_expandable_tree_hashchange = false;
      return false;
    }
    id = arr.shift();
    tree = $('.sortable_tree');
    node = $("[data-node-id=" + id + "]");
    ctrl_items = $('i.handle, b.expand', tree);
    if (node.length === 0) {
      return load_nested_nodes(arr, expand_node_url);
    } else {
      return $.ajax({
        type: 'POST',
        dataType: 'html',
        data: {
          id: id
        },
        url: expand_node_url,
        beforeSend: function(xhr) {
          ctrl_items.hide();
          return window.skip_expandable_tree_hashchange = true;
        },
        success: function(data, status, xhr) {
          ctrl_items.show();
          append_children_to_node(node, data);
          return load_nested_nodes(arr, expand_node_url);
        },
        error: function(xhr, status, error) {
          try {
            return console.log(error);
          } catch (_error) {}
        }
      });
    }
  };

  this.restore_nested_tree = function(sortable_tree, expand_node_url) {
    var arr;
    arr = nested_tree_get_path();
    if (!arr) {
      return false;
    }
    return load_nested_nodes(arr, expand_node_url);
  };

}).call(this);
