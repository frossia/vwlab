!function(e,t){"use strict";"object"==typeof module&&"object"==typeof module.exports?module.exports=e.document?t(e,!0):function(e){if(!e.document)throw new Error("AniJS requires a window with a document");return t(e)}:t(e)}("undefined"!=typeof window?window:this,function(e,t){var n=function(t){var n="data-anijs",r="default",i="$",o="if",a="on",v="do",l="to",s="(\\s+|^)",u="(\\s+|$)",c="animationend",f="transitionend";t={rootDOMTravelScope:{},eventProviderCollection:{},init:function(){d._t={};var e=d._a();t.registerHelper(r,e),d._u=r,t.rootDOMTravelScope=document,t.Parser=d.Parser,d._v=d._p(),d._w=""},setDOMRootTravelScope:function(e){var n;try{"document"===e?n=document:(n=document.querySelector(e),n||(n=document))}catch(r){n=document}t.rootDOMTravelScope=n},run:function(){var e=[],r={};t.purgeAll(),t.eventProviderCollection={},e=d._o(t.rootDOMTravelScope);var i,o=e.length,a=0;for(a;o>a;a++)i=e[a],r=d._n(i.getAttribute(n)),d._c(i,r)},createAnimation:function(e,t){var n=t||"";d._c(n,e)},getHelper:function(e){var t=d._t;return t[e]||t[r]},registerHelper:function(e,t){d._t[e]=t},purge:function(e){if(e&&""!==e&&" "!==e){var n=document.querySelectorAll(e),r=n.length,i=0;for(i;r>i;i++)t.EventSystem.purgeEventTarget(n[i])}},purgeAll:function(){t.EventSystem.purgeAll()},purgeEventTarget:function(e){t.EventSystem.purgeEventTarget(e)},setClassNamesWhenAnim:function(e){d._w=" "+e},createEventProvider:function(){return t.EventSystem.createEventTarget()},registerEventProvider:function(e){var n=t.eventProviderCollection;return e.id&&e.value&&t.EventSystem.isEventTarget(e.value)?(n[e.id]=e.value,1):""},getEventProvider:function(e){return t.eventProviderCollection[e]}};var d={};return d._a=function(){var e={removeAnim:function(e,t){t.nodeHelper.removeClass(e.target,t.behavior)},holdAnimClass:function(){}};return e},d._b=function(){return new Parser},d._c=function(e,t){var n,r=t.length,i=0;for(i;r>i;i++)n=t[i],d._d(e,n)},d._d=function(e,n){var r=d._e(n),i=d._f(e,n);if(""!==r){var o,a=i.length,v=0;for(v;a>v;v++)if(o=i[v],t.EventSystem.isEventTarget(o)){var l=function(r){var i=d._g(e,n),o=d._h(n),a=d._j(e,n),v=d._i(e,n);""!==d._w&&(o+=d._w);var l={behaviorTargetList:i,nodeHelper:d.NodeHelper,animationEndEvent:d._v,behavior:o,after:v,eventSystem:t.EventSystem},s=new d.AnimationContext(l);a&&d.Util.isFunction(a)?a(r,s):s.run()};t.EventSystem.addEventListenerHelper(o,r,l,!1),t.EventSystem.registerEventHandle(o,r,l)}}},d._e=function(e){var t="",n=e.event||t;return n===c?n=d._p():n===f&&(n=d._q()),n},d._f=function(n,r){var i,o=n,a=[o],v=t.rootDOMTravelScope;if(r.eventTarget)if(i=d._m(r.eventTarget),i.length>0)a=i;else if("document"===r.eventTarget)a=[document];else if("window"===r.eventTarget)a=[e];else if(r.eventTarget.split)try{a=v.querySelectorAll(r.eventTarget)}catch(l){a=[]}return a},d._g=function(e,n){var r=e,o=[r],a=t.rootDOMTravelScope,v=n.behaviorTarget;if(v){v=v.split(i).join(",");try{o=a.querySelectorAll(v)}catch(l){o=[]}}return o},d._h=function(e){var t=e.behavior||"";return t},d._i=function(e,t){var n=d._k(e,t,t.after);return n},d._j=function(e,t){var n=d._k(e,t,t.before);return n},d._k=function(e,t,n){var r=n||"",i=d._l(t);if(r&&!d.Util.isFunction(r)){var o=d._t,a=o[i];r=a&&a[r]?a[r]:!1}return r},d._l=function(e){var t=e.helper||d._u;return t},d._m=function(e){var n=[];if(t.eventProviderCollection,e)if(e.id&&t.EventSystem.isEventTarget(e.value))n.push(e.value),t.registerEventProvider(e);else if(e.split){eventProviderIDList=e.split("$");var r,i=eventProviderIDList.length,o=1;for(o;i>o;o++)if(r=eventProviderIDList[o],r&&" "!==r){r=r.trim();var a=t.getEventProvider(r);a||(a=t.EventSystem.createEventTarget(),t.registerEventProvider({id:r,value:a})),n.push(a)}}return n},d._n=function(e){return d.Parser.parse(e)},d._o=function(e){var t="["+n+"]";return e.querySelectorAll(t)},d._p=function(){var e=d._r(),t=[c,"oAnimationEnd",c,"webkitAnimationEnd"];return t[e]},d._q=function(){var e=d._r(),t=[f,"oTransitionEnd",f,"webkitTransitionEnd"];return t[e]},d._r=function(){for(var e=document.createElement("fakeelement"),t=["animation","OAnimation","MozAnimation","webkitAnimation"],n=0;n<t.length;n++)if(void 0!==e.style[t[n]])return n},d.AnimationContext=function(e){var t=this;t.init=function(e){t.behaviorTargetList=e.behaviorTargetList||[],t.nodeHelper=e.nodeHelper,t.animationEndEvent=e.animationEndEvent,t.behavior=e.behavior,t.after=e.after,t.eventSystem=e.eventSystem},t.run=function(){var e,n=t,r=n.behaviorTargetList,i=r.length,o=n.nodeHelper,a=n.behavior,v=n.animationEndEvent,l=n.after,s=0;for(s;i>s;s++)e=r[s],o.addClass(e,a),n.eventSystem.addEventListenerHelper(e,v,function(e){n.eventSystem.removeEventListenerHelper(e.target,e.type,arguments.callee),l?d.Util.isFunction(l)&&l(e,t):o.removeClass(e.target,a)})},t.init(e)},d.Parser={parse:function(e){return this.parseDeclaration(e)},parseDeclaration:function(e){var t,n,r=[];t=e.split(";");var i=t.length,o=0;for(o;i>o;o++)n=this.parseSentence(t[o]),r.push(n);return r},parseSentence:function(e){var t,n,r={};t=e.split(",");var i=t.length,o=0;for(o;i>o;o++)n=this.parseDefinition(t[o]),r[n.key]=n.value;return r},parseDefinition:function(e){var t,n,r,i={},s="event",u="eventTarget",c="behavior",f="behaviorTarget";return t=e.split(":"),t.length>1&&(n=t[0].trim(),r=t[1].trim(),n===o?n=s:n===a?n=u:n===v?n=c:n===l&&(n=f),i.key=n,i.value=r),i}},d.NodeHelper={addClass:function(e,t){t instanceof Array||(t=t.split(" "));for(var n=0,r=t.length;r>n;++n)t[n]&&!new RegExp(s+t[n]+u).test(e.className)&&(e.className=e.className.trim()+" "+t[n])},removeClass:function(e,t){t instanceof Array||(t=t.split(" "));for(var n=0,r=t.length;r>n;++n)e.className=e.className.replace(new RegExp(s+t[n]+u)," ").trim()},hasClass:function(e,t){return t&&new RegExp(s+t+u).test(e.className)}},d.Util={isFunction:function(e){return!!(e&&e.constructor&&e.call&&e.apply)}},t.EventSystem={eventCollection:{},eventIdCounter:0,isEventTarget:function(e){return e.addEventListener?1:0},createEventTarget:function(){return new t.EventTarget},addEventListenerHelper:function(e,t,n){e.addEventListener(t,n,!1)},removeEventListenerHelper:function(e,t,n){e.removeEventListener(t,n)},purgeAll:function(){var e,t,n=this,r=n.eventCollection,i=Object.keys(r),o=i.length,a=0;for(a;o>a;a++)e=i[a],t=r[e],t&&t.handleCollection&&t.handleCollection.length>0&&n.purgeEventTarget(t.handleCollection[0].element),delete r[e]},purgeEventTarget:function(e){var t,n=this,r=e._aniJSEventID;if(r){t=n.eventCollection[r].handleCollection;var i,o=t.length,a=0;for(a;o>a;a++)i=t[a],n.removeEventListenerHelper(e,i.eventType,i.listener);n.eventCollection[r]=e._aniJSEventID=null,delete n.eventCollection[r],delete e._aniJSEventID}},registerEventHandle:function(e,t,n){var r=this,i=e._aniJSEventID,o=r.eventCollection,a={eventType:t,listener:n,element:e};if(i)o[i].handleCollection.push(a);else{var v={handleCollection:[a]};o[++r.eventIdCounter]=v,e._aniJSEventID=r.eventIdCounter}}},t.EventTarget=function(){this._listeners={}},t.EventTarget.prototype={constructor:t.EventTarget,addEventListener:function(e,t){var n=this;"undefined"==typeof n._listeners[e]&&(n._listeners[e]=[]),n._listeners[e].push(t)},dispatchEvent:function(e){var t=this;if("string"==typeof e&&(e={type:e}),e.target||(e.target=t),!e.type)throw new Error("Event object missing 'type' property.");if(this._listeners[e.type]instanceof Array)for(var n=t._listeners[e.type],r=0,i=n.length;i>r;r++)n[r].call(t,e)},removeEventListener:function(e,t){var n=this;if(n._listeners[e]instanceof Array)for(var r=n._listeners[e],i=0,o=r.length;o>i;i++)if(r[i]===t){r.splice(i,1);break}}},t}(n||{});return n.init(),n.run(),"function"==typeof define&&define.amd&&define("anijs",[],function(){return n}),"undefined"==typeof t&&(e.AniJS=n),n});