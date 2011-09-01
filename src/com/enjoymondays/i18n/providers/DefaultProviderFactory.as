/**
 * Copyright (c) 2011 Enjoy Mondays
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package com.enjoymondays.i18n.providers {
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.i18n.core.IResourceBundleProvider;
	import com.enjoymondays.i18n.core.IResourceBundleProviderFactory;
	import com.enjoymondays.i18n.providers.loaders.XMLResourceBundleLoader;
	import com.enjoymondays.i18n.providers.parsers.XMLResourceBundleParser;
	import com.enjoymondays.i18n.providers.strategy.XMLProviderStrategy;
	import com.enjoymondays.i18n.ResourceBundleVO;
	import com.enjoymondays.data.HashMap;
	


	/**
	 * <code class="prettyprint">DefaultProviderFactory</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class DefaultProviderFactory implements IResourceBundleProviderFactory {
		
		static public const DEFAULT_PATH				:String = 'assets/xml/{0}/{1}.xml';
		static public const LANG_PREFIX					:String = 'lang_';
		
		protected var _mapping							:HashMap;
		
		
		/**
		 * <code class="prettyprint">DefaultProviderFactory</code>
		 * com.enjoymondays.i18n.providers.DefaultProviderFactory
		 */
		public function DefaultProviderFactory( ) {
			_mapping  = new HashMap;
		}
		
		/* INTERFACE com.enjoymondays.i18n.core.IResourceBundleProviderFactory */
		
		/**
		 * 
		 * @param	locale
		 * @param	provider
		 */
		public function mapProvider( locale:ILocale, provider:Class /*IREsouceProvider*/ ):void {
			_mapping.add( locale.code, provider );
		}
		
		/**
		 *
		 * @param	locale
		 * @return
		 */
		public function buildProvider( locale:ILocale ):IResourceBundleProvider {
			var provider:IResourceBundleProvider = new XMLProviderStrategy;
			provider.setLoader( new XMLResourceBundleLoader );
			/*
			 * REVISION Perhaps we want to assing a different id to main bundle, 
			 * instead of the XMLProviderStrategy id? Something like "root"
			 */ 
			provider.setParser( new XMLResourceBundleParser( XMLProviderStrategy.ID, locale ) );
			return provider;
		}	
		
		/**
		 *
		 * @param	locale
		 * @param	baseUrl
		 * @return
		 */
		public function buildBundleVO( locale:ILocale, baseUrl:String ):ResourceBundleVO {
			baseUrl = _buildUrl( locale, baseUrl );
			return new ResourceBundleVO( locale.code, baseUrl, locale );
		}
		
		/**
		 *
		 * @param	locale
		 * @param	baseUrl
		 * @return
		 * @private
		 */
		protected function _buildUrl( locale:ILocale, baseUrl:String ):String {
			
			if ( _search( baseUrl, DEFAULT_PATH ) ) baseUrl = baseUrl;
			else baseUrl = baseUrl + DEFAULT_PATH;
			
			baseUrl = _substitute( baseUrl, LANG_PREFIX + locale.code, locale.code );
			
			return baseUrl;
		}
		
		/**
		 * Search for key in string.
		 *
		 * @param str The target string.
		 * @param key The key to search for.
		 * @param caseSensitive Whether or not the search is case sensitive.
		 */
		public function _search( str:String, key:String, caseSensitive:Boolean = true):Boolean {
			if(!caseSensitive) {
				str = str.toUpperCase();
				key = key.toUpperCase();
			}
			return (str.indexOf(key) <= -1) ? false : true;
		}
		
		/**
	     *  Substitutes "{n}" tokens within the specified string
	     *  with the respective arguments passed in.
	     *
	     *  @param str The string to make substitutions in.
	     *  This string can contain special tokens of the form
	     *  <code class="prettyprint">{n}</code>, where <code class="prettyprint">n</code> is a zero based index,
	     *  that will be replaced with the additional parameters
	     *  found at that index if specified.
	     *
	     *  @param rest Additional parameters that can be substituted
	     *  in the <code class="prettyprint">str</code> parameter at each <code class="prettyprint">{n}</code>
	     *  location, where <code class="prettyprint">n</code> is an integer (zero based)
	     *  index value into the array of values specified.
	     *  If the first parameter is an array this array will be used as
	     *  a parameter list.
	     *  This allows reuse of this routine in other methods that want to
	     *  use the ... rest signature.
	     *  For example <pre>
	     *     public function myTracer(str:String, ... rest):void
	     *     {
	     *         label.text += StringUtil.substitute(str, rest) + "\n";
	     *     } </pre>
	     *
	     *  @return New string with all of the <code class="prettyprint">{n}</code> tokens
	     *  replaced with the respective arguments specified.
	     *
	     *  @example
	     *
	     *  var str:String = "here is some info '{0}' and {1}";
	     *  trace(StringUtil.substitute(str, 15.4, true));
	     *
	     *  // this will output the following string:
	     *  // "here is some info '15.4' and true"
	     */
		public function _substitute(str :String, ... rest) :String {
			// if someone passed an array as arg 1, fix it
			var args:Array =  (rest.length == 1 && (rest[0] is Array)) ? (rest[0] as Array) : rest;
			var len :int = args.length;
			// TODO: FIXME: this might be wrong, if your {0} replacement has a {1} in it, then
			// that'll get replaced next iteration.
			for (var i : int = 0; i < len; i++) str = str.replace(new RegExp("\\{" + i + "\\}", "g"), args[i]);
			return str;
		}
		
	}

}