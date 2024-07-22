'use strict';function e(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}function f(a){return a.raw=a}function g(a){if(!(a instanceof Array)){var b=typeof Symbol!="undefined"&&Symbol.iterator&&a[Symbol.iterator];if(b)a=b.call(a);else if(typeof a.length=="number")a={next:e(a)};else throw Error(String(a)+" is not an iterable or ArrayLike");for(var c=[];!(b=a.next()).done;)c.push(b.value);a=c}return a}
function h(){for(var a=Number(this),b=[],c=a;c<arguments.length;c++)b[c-a]=arguments[c];return b};/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
var k=this||self;function l(a){return a};var m;function n(a){this.g=a}n.prototype.toString=function(){return this.g+""};var p={};function q(a){if(m===void 0){var b=null;var c=k.trustedTypes;if(c&&c.createPolicy){try{b=c.createPolicy("goog#html",{createHTML:l,createScript:l,createScriptURL:l})}catch(d){k.console&&k.console.error(d.message)}m=b}else m=b}a=(b=m)?b.createScriptURL(a):a;return new n(a,p)};/*

 SPDX-License-Identifier: Apache-2.0
*/
var r=f(["extension_bundle.js"]);self.window=self;(function(a){a.importScripts.apply(a,g(h.apply(1,arguments).map(function(b){return b instanceof n&&b.constructor===n?b.g:"type_error:TrustedResourceUrl"})))})(self,function(a){var b=h.apply(1,arguments);if(b.length===0)return q(a[0]);for(var c=a[0],d=0;d<b.length;d++)c+=encodeURIComponent(b[d])+a[d+1];return q(c)}(r));docsOfflineExtensionEP.EventPage.createEventPage().load();
