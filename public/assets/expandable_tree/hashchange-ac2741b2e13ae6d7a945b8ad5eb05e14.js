(function(){this._arrays_diff=function(e,n){return n.filter(function(n){return!(e.indexOf(n)>-1)})},this.expandable_tree_hashchange=function(e){var n,a,t,r,h,i,_,s,c,d,o,f,l;if(window.skip_expandable_tree_hashchange)return window.skip_expandable_tree_hashchange=!1,!0;if(hash_and_cookie_accordance(),_=e.originalEvent,i=_.newURL,d=_.oldURL,h=i.split("#")[1],c=d.split("#")[1],!("#"+h).match(TSTconst.re())&&!("#"+c).match(TSTconst.re()))return!1;for(r=_nested_set_hash_arr(h),s=_nested_set_hash_arr(c),a=r.length>=s.length?_arrays_diff(s,r):_arrays_diff(r,s),l=[],o=0,f=a.length;f>o;o++)t=a[o],n=$("[data-node-id="+t+"] > .item .expand"),n.click(),l.push(setTimeout(function(){return window.skip_expandable_tree_hashchange=!1}));return l},$(window).bind("hashchange",function(e){return expandable_tree_hashchange(e)})}).call(this);