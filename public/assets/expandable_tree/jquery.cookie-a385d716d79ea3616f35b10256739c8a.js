(function() {
  (function(factory) {
    if (typeof define === "function" && define.amd) {
      return define(["jquery"], factory);
    } else {
      return factory(jQuery);
    }
  })(function($) {
    var config, converted, decoded, pluses, raw;
    pluses = /\+/g;
    raw = function(s) {
      return s;
    };
    decoded = function(s) {
      return decodeURIComponent(s.replace(pluses, " "));
    };
    converted = function(s) {
      if (s.indexOf("\"") === 0) {
        s = s.slice(1, -1).replace(/\\"/g, "\"").replace(/\\\\/g, "\\");
      }
      try {
        return (config.json ? JSON.parse(s) : s);
      } catch (_error) {}
    };
    config = $.cookie = function(key, value, options) {
      var cookie, cookies, days, decode, i, l, name, parts, result, t;
      if (value !== undefined) {
        options = $.extend({}, config.defaults, options);
        if (typeof options.expires === "number") {
          days = options.expires;
          t = options.expires = new Date();
          t.setDate(t.getDate() + days);
        }
        value = (config.json ? JSON.stringify(value) : String(value));
        return (document.cookie = [(config.raw ? key : encodeURIComponent(key)), "=", (config.raw ? value : encodeURIComponent(value)), (options.expires ? "; expires=" + options.expires.toUTCString() : ""), (options.path ? "; path=" + options.path : ""), (options.domain ? "; domain=" + options.domain : ""), (options.secure ? "; secure" : "")].join(""));
      }
      decode = (config.raw ? raw : decoded);
      cookies = document.cookie.split("; ");
      result = (key ? undefined : {});
      i = 0;
      l = cookies.length;
      while (i < l) {
        parts = cookies[i].split("=");
        name = decode(parts.shift());
        cookie = decode(parts.join("="));
        if (key && key === name) {
          result = converted(cookie);
          break;
        }
        if (!key) {
          result[name] = converted(cookie);
        }
        i++;
      }
      return result;
    };
    config.defaults = {};
    return $.removeCookie = function(key, options) {
      if ($.cookie(key) !== undefined) {
        $.cookie(key, '', $.extend({}, options, {
          expires: -1
        }));
        return true;
      }
      return false;
    };
  });

}).call(this);
