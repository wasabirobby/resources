var app=function(){"use strict";function e(){}function t(e){return e()}function s(){return Object.create(null)}function n(e){e.forEach(t)}function i(e){return"function"==typeof e}function l(e,t){return e!=e?t==t:e!==t||e&&"object"==typeof e||"function"==typeof e}let c,r;function o(e,t){return c||(c=document.createElement("a")),c.href=t,e===c.href}function a(e){return null==e?"":e}function f(e,t){e.appendChild(t)}function m(e,t,s){e.insertBefore(t,s||null)}function u(e){e.parentNode.removeChild(e)}function v(e,t){for(let s=0;s<e.length;s+=1)e[s]&&e[s].d(t)}function h(e){return document.createElement(e)}function p(e){return document.createTextNode(e)}function d(){return p(" ")}function k(){return p("")}function g(e,t,s,n){return e.addEventListener(t,s,n),()=>e.removeEventListener(t,s,n)}function $(e,t,s){null==s?e.removeAttribute(t):e.getAttribute(t)!==s&&e.setAttribute(t,s)}function y(e,t){t=""+t,e.wholeText!==t&&(e.data=t)}function T(e,t,s,n){null===s?e.style.removeProperty(t):e.style.setProperty(t,s,n?"important":"")}function w(e){r=e}const b=[],x=[],H=[],R=[],L=Promise.resolve();let P=!1;function C(e){H.push(e)}const I=new Set;let _=0;function N(){const e=r;do{for(;_<b.length;){const e=b[_];_++,w(e),A(e.$$)}for(w(null),b.length=0,_=0;x.length;)x.pop()();for(let e=0;e<H.length;e+=1){const t=H[e];I.has(t)||(I.add(t),t())}H.length=0}while(b.length);for(;R.length;)R.pop()();P=!1,I.clear(),w(e)}function A(e){if(null!==e.fragment){e.update(),n(e.before_update);const t=e.dirty;e.dirty=[-1],e.fragment&&e.fragment.p(e.ctx,t),e.after_update.forEach(C)}}const D=new Set;function E(e,t){-1===e.$$.dirty[0]&&(b.push(e),P||(P=!0,L.then(N)),e.$$.dirty.fill(0)),e.$$.dirty[t/31|0]|=1<<t%31}function M(l,c,o,a,f,m,v,h=[-1]){const p=r;w(l);const d=l.$$={fragment:null,ctx:null,props:m,update:e,not_equal:f,bound:s(),on_mount:[],on_destroy:[],on_disconnect:[],before_update:[],after_update:[],context:new Map(c.context||(p?p.$$.context:[])),callbacks:s(),dirty:h,skip_bound:!1,root:c.target||p.$$.root};v&&v(d.root);let k=!1;if(d.ctx=o?o(l,c.props||{},((e,t,...s)=>{const n=s.length?s[0]:t;return d.ctx&&f(d.ctx[e],d.ctx[e]=n)&&(!d.skip_bound&&d.bound[e]&&d.bound[e](n),k&&E(l,e)),t})):[],d.update(),k=!0,n(d.before_update),d.fragment=!!a&&a(d.ctx),c.target){if(c.hydrate){const e=function(e){return Array.from(e.childNodes)}(c.target);d.fragment&&d.fragment.l(e),e.forEach(u)}else d.fragment&&d.fragment.c();c.intro&&((g=l.$$.fragment)&&g.i&&(D.delete(g),g.i($))),function(e,s,l,c){const{fragment:r,on_mount:o,on_destroy:a,after_update:f}=e.$$;r&&r.m(s,l),c||C((()=>{const s=o.map(t).filter(i);a?a.push(...s):n(s),e.$$.on_mount=[]})),f.forEach(C)}(l,c.target,c.anchor,c.customElement),N()}var g,$;w(p)}function O(e,t,s){const n=e.slice();return n[20]=t[s],n}function S(e,t,s){const n=e.slice();return n[20]=t[s],n}function j(e,t,s){const n=e.slice();return n[20]=t[s],n[26]=s,n}function B(e,t,s){const n=e.slice();return n[20]=t[s],n[26]=s,n}function J(e){let t,s,i,l,c,r,o,k,y,T,w,b,x,H,R,L,P,C,I,_,N,A,D,E,M,O,S,B,J,F,q,z=e[1].LongTerm,W=[];for(let t=0;t<z.length;t+=1)W[t]=Q(j(e,z,t));return{c(){t=h("div"),s=h("div"),i=h("div"),i.innerHTML='<p class="svelte-1shk9f0">To the choice of investments</p>',l=d(),c=h("div"),r=h("p"),r.textContent="Long-Term",o=d(),k=h("ul"),y=h("li"),T=p("100 hours"),b=d(),x=h("li"),H=p("200 hours"),L=d(),P=h("li"),C=p("300 hours"),_=d(),N=h("li"),A=p("400 hours"),E=d(),M=h("li"),O=p("500 hours"),B=d(),J=h("div");for(let e=0;e<W.length;e+=1)W[e].c();$(i,"class","investments-goback svelte-1shk9f0"),$(r,"class","investments-page-header svelte-1shk9f0"),$(y,"class",w=a(1==e[4]?"active":"")+" svelte-1shk9f0"),$(x,"class",R=a(2==e[4]?"active":"")+" svelte-1shk9f0"),$(P,"class",I=a(3==e[4]?"active":"")+" svelte-1shk9f0"),$(N,"class",D=a(4==e[4]?"active":"")+" svelte-1shk9f0"),$(M,"class",S=a(5==e[4]?"active":"")+" svelte-1shk9f0"),$(k,"class","investments-page-days svelte-1shk9f0"),$(c,"class","investments-page-header-wrapper svelte-1shk9f0"),$(s,"class","investments-page-wrapper-top svelte-1shk9f0"),$(J,"class","investments-list-wrapper svelte-1shk9f0"),$(t,"class","investments-page-wrapper svelte-1shk9f0")},m(n,a){m(n,t,a),f(t,s),f(s,i),f(s,l),f(s,c),f(c,r),f(c,o),f(c,k),f(k,y),f(y,T),f(k,b),f(k,x),f(x,H),f(k,L),f(k,P),f(P,C),f(k,_),f(k,N),f(N,A),f(k,E),f(k,M),f(M,O),f(t,B),f(t,J);for(let e=0;e<W.length;e+=1)W[e].m(J,null);F||(q=[g(i,"click",e[12]),g(y,"click",e[13]),g(x,"click",e[14]),g(P,"click",e[15]),g(N,"click",e[16]),g(M,"click",e[17])],F=!0)},p(e,t){if(16&t&&w!==(w=a(1==e[4]?"active":"")+" svelte-1shk9f0")&&$(y,"class",w),16&t&&R!==(R=a(2==e[4]?"active":"")+" svelte-1shk9f0")&&$(x,"class",R),16&t&&I!==(I=a(3==e[4]?"active":"")+" svelte-1shk9f0")&&$(P,"class",I),16&t&&D!==(D=a(4==e[4]?"active":"")+" svelte-1shk9f0")&&$(N,"class",D),16&t&&S!==(S=a(5==e[4]?"active":"")+" svelte-1shk9f0")&&$(M,"class",S),26&t){let s;for(z=e[1].LongTerm,s=0;s<z.length;s+=1){const n=j(e,z,s);W[s]?W[s].p(n,t):(W[s]=Q(n),W[s].c(),W[s].m(J,null))}for(;s<W.length;s+=1)W[s].d(1);W.length=z.length}},d(e){e&&u(t),v(W,e),F=!1,n(q)}}}function F(e){let t,s,n,i,l,c,r,o,a,p=e[1].DayTime,k=[];for(let t=0;t<p.length;t+=1)k[t]=ee(B(e,p,t));return{c(){t=h("div"),s=h("div"),n=h("div"),n.innerHTML='<p class="svelte-1shk9f0">To the choice of investments</p>',i=d(),l=h("p"),l.textContent="Daytime",c=d(),r=h("div");for(let e=0;e<k.length;e+=1)k[e].c();$(n,"class","investments-goback svelte-1shk9f0"),$(l,"class","investments-page-header svelte-1shk9f0"),$(s,"class","investments-page-wrapper-top svelte-1shk9f0"),$(r,"class","investments-list-wrapper svelte-1shk9f0"),$(t,"class","investments-page-wrapper svelte-1shk9f0")},m(u,v){m(u,t,v),f(t,s),f(s,n),f(s,i),f(s,l),f(t,c),f(t,r);for(let e=0;e<k.length;e+=1)k[e].m(r,null);o||(a=g(n,"click",e[9]),o=!0)},p(e,t){if(6&t){let s;for(p=e[1].DayTime,s=0;s<p.length;s+=1){const n=B(e,p,s);k[s]?k[s].p(n,t):(k[s]=ee(n),k[s].c(),k[s].m(r,null))}for(;s<k.length;s+=1)k[s].d(1);k.length=p.length}},d(e){e&&u(t),v(k,e),o=!1,a()}}}function q(t){let s,i,l,c,r,o,a;return{c(){s=h("p"),s.textContent="Investments",i=d(),l=h("div"),l.innerHTML='<p class="svelte-1shk9f0">Daytime<span class="svelte-1shk9f0">Free</span></p>',c=d(),r=h("div"),r.innerHTML='<p class="svelte-1shk9f0"><span class="svelte-1shk9f0">from 1 day to 100 days</span>Long-term</p>',$(s,"class","investments-center-text svelte-1shk9f0"),$(l,"class","investments-option-left svelte-1shk9f0"),$(r,"class","investments-option-right svelte-1shk9f0")},m(e,n){m(e,s,n),m(e,i,n),m(e,l,n),m(e,c,n),m(e,r,n),o||(a=[g(l,"click",t[7]),g(r,"click",t[8])],o=!0)},p:e,d(e){e&&u(s),e&&u(i),e&&u(l),e&&u(c),e&&u(r),o=!1,n(a)}}}function z(e){let t,s,n,i,l,c,r,v,k,g,T,w,b,x,H,R,L,P,C,I,_,N,A,D,E,M,O,S,j,B,J,F,q,z,G,K,Q,U,V=e[26]+1+"",X=e[20].Cost+"",Z=e[20].Hours+"",ee=e[20].Profit+"",te=e[20].Hours+"",se=e[20].Cost+"",ne=e[20].Profit+"";function ie(e,t){return e[3]?Y:e[20].Active?W:void 0}let le=ie(e),ce=le&&le(e);return{c(){t=h("div"),s=h("img"),i=d(),l=h("div"),c=h("p"),r=p("Investment #"),v=p(V),k=d(),g=h("p"),T=p("You invest $"),w=p(X),b=p(" and in "),x=p(Z),H=p(" hours you get your money back and an additional $"),R=p(ee),L=d(),P=h("div"),C=h("p"),I=p("Duration "),_=h("span"),N=p(te),A=p(" hours"),D=d(),E=h("div"),M=h("div"),O=h("p"),S=p("Cost"),j=h("span"),B=p("$"),J=p(se),F=d(),q=h("p"),z=p("+$"),G=p(ne),K=d(),ce&&ce.c(),Q=d(),$(s,"alt",""),o(s.src,n=e[20].ImgLink)||$(s,"src",n),$(s,"class","svelte-1shk9f0"),$(c,"class","investments-item-name svelte-1shk9f0"),$(g,"class","investments-item-description svelte-1shk9f0"),$(_,"class","svelte-1shk9f0"),$(C,"class","investments-item-time svelte-1shk9f0"),$(P,"class","investments-item-time-wrapper svelte-1shk9f0"),$(l,"class","investments-item-content svelte-1shk9f0"),$(j,"class","svelte-1shk9f0"),$(O,"class","investments-item-profit-val svelte-1shk9f0"),$(q,"class","investments-item-profit-val-green svelte-1shk9f0"),$(M,"class","investments-item-profit svelte-1shk9f0"),$(E,"class","investments-item-content-right svelte-1shk9f0"),$(t,"class",U=a(ue(e[20]))+" svelte-1shk9f0")},m(e,n){m(e,t,n),f(t,s),f(t,i),f(t,l),f(l,c),f(c,r),f(c,v),f(l,k),f(l,g),f(g,T),f(g,w),f(g,b),f(g,x),f(g,H),f(g,R),f(l,L),f(l,P),f(P,C),f(C,I),f(C,_),f(_,N),f(_,A),f(t,D),f(t,E),f(E,M),f(M,O),f(O,S),f(O,j),f(j,B),f(j,J),f(M,F),f(M,q),f(q,z),f(q,G),f(E,K),ce&&ce.m(E,null),f(t,Q)},p(e,i){2&i&&!o(s.src,n=e[20].ImgLink)&&$(s,"src",n),2&i&&X!==(X=e[20].Cost+"")&&y(w,X),2&i&&Z!==(Z=e[20].Hours+"")&&y(x,Z),2&i&&ee!==(ee=e[20].Profit+"")&&y(R,ee),2&i&&te!==(te=e[20].Hours+"")&&y(N,te),2&i&&se!==(se=e[20].Cost+"")&&y(J,se),2&i&&ne!==(ne=e[20].Profit+"")&&y(G,ne),le===(le=ie(e))&&ce?ce.p(e,i):(ce&&ce.d(1),ce=le&&le(e),ce&&(ce.c(),ce.m(E,null))),2&i&&U!==(U=a(ue(e[20]))+" svelte-1shk9f0")&&$(t,"class",U)},d(e){e&&u(t),ce&&ce.d()}}}function W(e){let t;function s(e,t){return 0==e[20].RemainTime?K:G}let n=s(e),i=n(e);return{c(){t=h("div"),i.c(),$(t,"class","investments-item-button svelte-1shk9f0")},m(e,s){m(e,t,s),i.m(t,null)},p(e,l){n===(n=s(e))&&i?i.p(e,l):(i.d(1),i=n(e),i&&(i.c(),i.m(t,null)))},d(e){e&&u(t),i.d()}}}function Y(e){let t,s,n,i;function l(){return e[18](e[20],e[26])}return{c(){t=h("div"),s=h("button"),s.textContent="Invest",$(s,"class","svelte-1shk9f0"),$(t,"class","investments-item-button svelte-1shk9f0")},m(e,c){m(e,t,c),f(t,s),n||(i=g(s,"click",l),n=!0)},p(t,s){e=t},d(e){e&&u(t),n=!1,i()}}}function G(e){let t,s,n,i,l,c,r,o,a,v,k,g,w=fe(1,e[20].Hours,e[20].RemainTime)+"";return{c(){t=h("div"),s=h("p"),n=p("Time left"),i=h("br"),l=p("to get profit"),c=h("span"),r=p(w),o=d(),a=h("div"),v=h("span"),k=d(),g=h("span"),$(i,"class","svelte-1shk9f0"),$(c,"class","svelte-1shk9f0"),$(s,"class","svelte-1shk9f0"),$(v,"class","gray svelte-1shk9f0"),T(v,"height",fe(2,e[20].Hours,e[20].RemainTime)+"%"),$(g,"class","green svelte-1shk9f0"),T(g,"height",100-fe(2,e[20].Hours,e[20].RemainTime)+"%"),$(a,"class","investments-item-progressbar svelte-1shk9f0"),$(t,"class","investments-item-progress svelte-1shk9f0")},m(e,u){m(e,t,u),f(t,s),f(s,n),f(s,i),f(s,l),f(s,c),f(c,r),f(t,o),f(t,a),f(a,v),f(a,k),f(a,g)},p(e,t){2&t&&w!==(w=fe(1,e[20].Hours,e[20].RemainTime)+"")&&y(r,w),2&t&&T(v,"height",fe(2,e[20].Hours,e[20].RemainTime)+"%"),2&t&&T(g,"height",100-fe(2,e[20].Hours,e[20].RemainTime)+"%")},d(e){e&&u(t)}}}function K(t){let s,n,i;return{c(){s=h("button"),s.textContent="Take profit",$(s,"class","svelte-1shk9f0")},m(e,l){m(e,s,l),n||(i=g(s,"click",t[19]),n=!0)},p:e,d(e){e&&u(s),n=!1,i()}}}function Q(e){let t,s=e[20].Hours==100*e[4]&&z(e);return{c(){s&&s.c(),t=k()},m(e,n){s&&s.m(e,n),m(e,t,n)},p(e,n){e[20].Hours==100*e[4]?s?s.p(e,n):(s=z(e),s.c(),s.m(t.parentNode,t)):s&&(s.d(1),s=null)},d(e){s&&s.d(e),e&&u(t)}}}function U(e){let t;function s(e,t){return 0==e[20].RemainTime?Z:X}let n=s(e),i=n(e);return{c(){t=h("div"),i.c(),$(t,"class","investments-item-button svelte-1shk9f0")},m(e,s){m(e,t,s),i.m(t,null)},p(e,l){n===(n=s(e))&&i?i.p(e,l):(i.d(1),i=n(e),i&&(i.c(),i.m(t,null)))},d(e){e&&u(t),i.d()}}}function V(e){let t,s,n,i;function l(){return e[10](e[20],e[26])}return{c(){t=h("div"),s=h("button"),s.textContent="Invest",$(s,"class","svelte-1shk9f0"),$(t,"class","investments-item-button svelte-1shk9f0")},m(e,c){m(e,t,c),f(t,s),n||(i=g(s,"click",l),n=!0)},p(t,s){e=t},d(e){e&&u(t),n=!1,i()}}}function X(e){let t,s,n,i,l,c,r,o,a,v,k,g,w=fe(1,e[20].Hours,e[20].RemainTime)+"";return{c(){t=h("div"),s=h("p"),n=p("Time left"),i=h("br"),l=p("to get profit"),c=h("span"),r=p(w),o=d(),a=h("div"),v=h("span"),k=d(),g=h("span"),$(i,"class","svelte-1shk9f0"),$(c,"class","svelte-1shk9f0"),$(s,"class","svelte-1shk9f0"),$(v,"class","gray svelte-1shk9f0"),T(v,"height",fe(2,e[20].Hours,e[20].RemainTime)+"%"),$(g,"class","green svelte-1shk9f0"),T(g,"height",100-fe(2,e[20].Hours,e[20].RemainTime)+"%"),$(a,"class","investments-item-progressbar svelte-1shk9f0"),$(t,"class","investments-item-progress svelte-1shk9f0")},m(e,u){m(e,t,u),f(t,s),f(s,n),f(s,i),f(s,l),f(s,c),f(c,r),f(t,o),f(t,a),f(a,v),f(a,k),f(a,g)},p(e,t){2&t&&w!==(w=fe(1,e[20].Hours,e[20].RemainTime)+"")&&y(r,w),2&t&&T(v,"height",fe(2,e[20].Hours,e[20].RemainTime)+"%"),2&t&&T(g,"height",100-fe(2,e[20].Hours,e[20].RemainTime)+"%")},d(e){e&&u(t)}}}function Z(t){let s,n,i;return{c(){s=h("button"),s.textContent="Take profit",$(s,"class","svelte-1shk9f0")},m(e,l){m(e,s,l),n||(i=g(s,"click",t[11]),n=!0)},p:e,d(e){e&&u(s),n=!1,i()}}}function ee(e){let t,s,n,i,l,c,r,v,k,g,T,w,b,x,H,R,L,P,C,I,_,N,A,D,E,M,O,S,j,B,J,F,q,z,W,Y,G,K=e[26]+1+"",Q=e[20].Profit+"",X=e[20].Hours+"",Z=e[20].Hours+"",ee=e[20].Profit+"",te=e[20].Profit+"";function se(e,t){return e[2]?V:e[20].Active?U:void 0}let ne=se(e),ie=ne&&ne(e);return{c(){t=h("div"),s=h("img"),i=d(),l=h("div"),c=h("p"),r=p("Investment #"),v=p(K),k=d(),g=h("p"),T=p("This investment will bring you $"),w=p(Q),b=p(" net profit in "),x=p(X),H=p(" hours"),R=d(),L=h("div"),P=h("p"),C=p("Duration "),I=h("span"),_=p(Z),N=p(" hours"),A=d(),D=h("div"),E=h("div"),M=h("p"),O=p("Profit"),S=h("span"),j=p("$"),B=p(ee),J=d(),F=h("p"),q=p("+$"),z=p(te),W=d(),ie&&ie.c(),Y=d(),$(s,"alt",""),o(s.src,n=e[20].ImgLink)||$(s,"src",n),$(s,"class","svelte-1shk9f0"),$(c,"class","investments-item-name svelte-1shk9f0"),$(g,"class","investments-item-description svelte-1shk9f0"),$(I,"class","svelte-1shk9f0"),$(P,"class","investments-item-time svelte-1shk9f0"),$(L,"class","investments-item-time-wrapper svelte-1shk9f0"),$(l,"class","investments-item-content svelte-1shk9f0"),$(S,"class","svelte-1shk9f0"),$(M,"class","investments-item-profit-val svelte-1shk9f0"),$(F,"class","investments-item-profit-val-green svelte-1shk9f0"),$(E,"class","investments-item-profit svelte-1shk9f0"),$(D,"class","investments-item-content-right svelte-1shk9f0"),$(t,"class",G=a(ue(e[20]))+" svelte-1shk9f0")},m(e,n){m(e,t,n),f(t,s),f(t,i),f(t,l),f(l,c),f(c,r),f(c,v),f(l,k),f(l,g),f(g,T),f(g,w),f(g,b),f(g,x),f(g,H),f(l,R),f(l,L),f(L,P),f(P,C),f(P,I),f(I,_),f(I,N),f(t,A),f(t,D),f(D,E),f(E,M),f(M,O),f(M,S),f(S,j),f(S,B),f(E,J),f(E,F),f(F,q),f(F,z),f(D,W),ie&&ie.m(D,null),f(t,Y)},p(e,i){2&i&&!o(s.src,n=e[20].ImgLink)&&$(s,"src",n),2&i&&Q!==(Q=e[20].Profit+"")&&y(w,Q),2&i&&X!==(X=e[20].Hours+"")&&y(x,X),2&i&&Z!==(Z=e[20].Hours+"")&&y(_,Z),2&i&&ee!==(ee=e[20].Profit+"")&&y(B,ee),2&i&&te!==(te=e[20].Profit+"")&&y(z,te),ne===(ne=se(e))&&ie?ie.p(e,i):(ie&&ie.d(1),ie=ne&&ne(e),ie&&(ie.c(),ie.m(D,null))),2&i&&G!==(G=a(ue(e[20]))+" svelte-1shk9f0")&&$(t,"class",G)},d(e){e&&u(t),ie&&ie.d()}}}function te(e){let t,s,n;function i(e,n){return 2&n&&(t=null),2&n&&(s=null),null==t&&(t=!!he(e[1].DayTime)),t?ne:(null==s&&(s=!!he(e[1].LongTerm)),s?se:void 0)}let l=i(e,-1),c=l&&l(e);return{c(){c&&c.c(),n=k()},m(e,t){c&&c.m(e,t),m(e,n,t)},p(e,t){l===(l=i(e,t))&&c?c.p(e,t):(c&&c.d(1),c=l&&l(e),c&&(c.c(),c.m(n.parentNode,n)))},d(e){c&&c.d(e),e&&u(n)}}}function se(e){let t,s=e[1].LongTerm,n=[];for(let t=0;t<s.length;t+=1)n[t]=le(O(e,s,t));return{c(){for(let e=0;e<n.length;e+=1)n[e].c();t=k()},m(e,s){for(let t=0;t<n.length;t+=1)n[t].m(e,s);m(e,t,s)},p(e,i){if(2&i){let l;for(s=e[1].LongTerm,l=0;l<s.length;l+=1){const c=O(e,s,l);n[l]?n[l].p(c,i):(n[l]=le(c),n[l].c(),n[l].m(t.parentNode,t))}for(;l<n.length;l+=1)n[l].d(1);n.length=s.length}},d(e){v(n,e),e&&u(t)}}}function ne(e){let t,s=e[1].DayTime,n=[];for(let t=0;t<s.length;t+=1)n[t]=re(S(e,s,t));return{c(){for(let e=0;e<n.length;e+=1)n[e].c();t=k()},m(e,s){for(let t=0;t<n.length;t+=1)n[t].m(e,s);m(e,t,s)},p(e,i){if(2&i){let l;for(s=e[1].DayTime,l=0;l<s.length;l+=1){const c=S(e,s,l);n[l]?n[l].p(c,i):(n[l]=re(c),n[l].c(),n[l].m(t.parentNode,t))}for(;l<n.length;l+=1)n[l].d(1);n.length=s.length}},d(e){v(n,e),e&&u(t)}}}function ie(e){let t,s,n,i,l,c,r,a,v,k,g,T,w,b,x,H=ve(e[20].RemainTime)+"",R=e[20].Cost+e[20].Profit+"";return{c(){t=h("div"),s=h("p"),n=p("Remaining"),i=h("span"),l=p(H),c=h("span"),c.textContent="Before receiving",r=d(),a=h("div"),v=h("p"),k=p(R),g=p("$"),T=d(),w=h("img"),x=d(),$(i,"class","svelte-1shk9f0"),$(c,"class","span svelte-1shk9f0"),$(s,"class","svelte-1shk9f0"),$(v,"class","svelte-1shk9f0"),$(a,"class","active-investments-text svelte-1shk9f0"),$(w,"alt",""),o(w.src,b="https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png")||$(w,"src","https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png"),$(w,"class","svelte-1shk9f0"),$(t,"class","active-investments svelte-1shk9f0")},m(e,o){m(e,t,o),f(t,s),f(s,n),f(s,i),f(i,l),f(s,c),f(t,r),f(t,a),f(a,v),f(v,k),f(v,g),f(t,T),f(t,w),f(t,x)},p(e,t){2&t&&H!==(H=ve(e[20].RemainTime)+"")&&y(l,H),2&t&&R!==(R=e[20].Cost+e[20].Profit+"")&&y(k,R)},d(e){e&&u(t)}}}function le(e){let t,s=e[20].Active&&ie(e);return{c(){s&&s.c(),t=k()},m(e,n){s&&s.m(e,n),m(e,t,n)},p(e,n){e[20].Active?s?s.p(e,n):(s=ie(e),s.c(),s.m(t.parentNode,t)):s&&(s.d(1),s=null)},d(e){s&&s.d(e),e&&u(t)}}}function ce(e){let t,s,n,i,l,c,r,a,v,k,g,T,w,b,x,H=ve(e[20].RemainTime)+"",R=e[20].Profit+"";return{c(){t=h("div"),s=h("p"),n=p("Remaining"),i=h("span"),l=p(H),c=h("span"),c.textContent="Before receiving",r=d(),a=h("div"),v=h("p"),k=p(R),g=p("$"),T=d(),w=h("img"),x=d(),$(i,"class","svelte-1shk9f0"),$(c,"class","span svelte-1shk9f0"),$(s,"class","svelte-1shk9f0"),$(v,"class","svelte-1shk9f0"),$(a,"class","active-investments-text svelte-1shk9f0"),$(w,"alt",""),o(w.src,b="https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png")||$(w,"src","https://cdn.discordapp.com/attachments/928768829675429938/1018147353854750790/unknown.png"),$(w,"class","svelte-1shk9f0"),$(t,"class","active-investments svelte-1shk9f0")},m(e,o){m(e,t,o),f(t,s),f(s,n),f(s,i),f(i,l),f(s,c),f(t,r),f(t,a),f(a,v),f(v,k),f(v,g),f(t,T),f(t,w),f(t,x)},p(e,t){2&t&&H!==(H=ve(e[20].RemainTime)+"")&&y(l,H),2&t&&R!==(R=e[20].Profit+"")&&y(k,R)},d(e){e&&u(t)}}}function re(e){let t,s=e[20].Active&&ce(e);return{c(){s&&s.c(),t=k()},m(e,n){s&&s.m(e,n),m(e,t,n)},p(e,n){e[20].Active?s?s.p(e,n):(s=ce(e),s.c(),s.m(t.parentNode,t)):s&&(s.d(1),s=null)},d(e){s&&s.d(e),e&&u(t)}}}function oe(t){let s,n,i,l,c,r;function o(e,t){return 0==e[0]?q:1==e[0]?F:2==e[0]?J:void 0}let a=o(t),v=a&&a(t),p=t[5]&&te(t);return{c(){s=h("main"),n=h("i"),i=d(),l=h("div"),v&&v.c(),c=d(),p&&p.c(),r=k(),$(n,"class","investments-bg svelte-1shk9f0"),$(l,"class","investments-wrapper svelte-1shk9f0"),$(s,"class","svelte-1shk9f0")},m(e,t){m(e,s,t),f(s,n),f(s,i),f(s,l),v&&v.m(l,null),m(e,c,t),p&&p.m(e,t),m(e,r,t)},p(e,[t]){a===(a=o(e))&&v?v.p(e,t):(v&&v.d(1),v=a&&a(e),v&&(v.c(),v.m(l,null))),e[5]?p?p.p(e,t):(p=te(e),p.c(),p.m(r.parentNode,r)):p&&(p.d(1),p=null)},i:e,o:e,d(e){e&&u(s),v&&v.d(),e&&u(c),p&&p.d(e),e&&u(r)}}}function ae(e,t,s){e.Index=t,e.Type=s,window.$.post("https://3core-investments/startInvestment",JSON.stringify({investmentData:e}))}function fe(e,t,s){if(1==e){let e=parseInt(Math.floor(s/3600));return e<60?Math.floor(s/60)+" minutes":e+" hours"}if(2==e)return parseInt((s/(3600*t)*100).toFixed())}function me(e){window.$.post("https://3core-investments/takeProfit",JSON.stringify({type:e}))}function ue(e){return e.Active?0==e.RemainTime?"investments-list-item take":"investments-list-item active":"investments-list-item"}function ve(e){var t=parseInt(e,10),s=Math.floor(t/3600),n=Math.floor((t-3600*s)/60);return s<10&&(s="0"+s),n<10&&(n="0"+n),s+":"+n}function he(e){let t=!1;for(let s=0;s<e.length;s++)e[s].Active&&0!=e[s.RemainTime]&&(t=!0);return t}function pe(e,t,s){let n,i,l=0,c=[],r=1,o=!1;function a(e){s(0,l=e)}window.$(document).ready((function(){window.addEventListener("message",(e=>{switch(e.data.type){case"showPage":window.$("main").show(),window.$(".investments-wrapper").css("zoom",(t=document.body.clientWidth/1920,l=document.body.clientHeight/1080,t<l?t:l)),s(1,c=e.data.investments),s(2,n=e.data.canInvest1),s(3,i=e.data.canInvest2);break;case"update":s(1,c=e.data.investments),s(2,n=e.data.canInvest1),s(3,i=e.data.canInvest2);break;case"showTime":s(5,o=!0);break;case"hideTime":s(5,o=!1);break;case"updateInvestments":s(1,c=e.data.investments)}var t,l})),window.$(document).keyup((function(e){27==e.keyCode&&(window.$("main").hide(),window.$.post("https://3core-investments/close",JSON.stringify({})))}))}));return[l,c,n,i,r,o,a,()=>a(1),()=>a(2),()=>a(0),(e,t)=>ae(e,t+1,"DayTime"),()=>me("DayTime"),()=>a(0),()=>s(4,r=1),()=>s(4,r=2),()=>s(4,r=3),()=>s(4,r=4),()=>s(4,r=5),(e,t)=>ae(e,t+1,"LongTerm"),()=>me("LongTerm")]}return new class extends class{$destroy(){!function(e,t){const s=e.$$;null!==s.fragment&&(n(s.on_destroy),s.fragment&&s.fragment.d(t),s.on_destroy=s.fragment=null,s.ctx=[])}(this,1),this.$destroy=e}$on(e,t){const s=this.$$.callbacks[e]||(this.$$.callbacks[e]=[]);return s.push(t),()=>{const e=s.indexOf(t);-1!==e&&s.splice(e,1)}}$set(e){var t;this.$$set&&(t=e,0!==Object.keys(t).length)&&(this.$$.skip_bound=!0,this.$$set(e),this.$$.skip_bound=!1)}}{constructor(e){super(),M(this,e,pe,oe,l,{})}}({target:document.body})}();
