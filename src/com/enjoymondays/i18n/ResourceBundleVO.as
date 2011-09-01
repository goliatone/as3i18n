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
package com.enjoymondays.i18n {
	
	import com.enjoymondays.i18n.core.ILocale;


	/**
	 * <code class="prettyprint">ResourceBundleVO</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class ResourceBundleVO {
		
		/** @private **/
		private var _id						:String;
		
		/** @private **/
		private var _url					:String;
		
		/** @private **/
		private var _locale					:ILocale;
		
		/**
		 * <code class="prettyprint">ResourceBundleVO</code>
		 * com.enjoymondays.i18n.ResourceBundleVO
		 */
		public function ResourceBundleVO( id:String = null, url:String = null, locale:ILocale = null ) {
			if( id ) 	 this.id = id;
			if( url ) 	 this.url = url;
			if( locale ) this.locale = locale;
		}		
		
		/**
		 * 
		 */
		public function get id( ):String { return _id; }		
		/** @private */
		public function set id( value:String ):void {
			_id = value;
		}
		
		/**
		 * 
		 */
		public function get url():String { return _url; }		
		/** @private */
		public function set url( value:String ):void {
			_url = value;
		}
		
		/**
		 * 
		 */
		public function get locale( ):ILocale { return _locale; }		
		/** @private */
		public function set locale( value:ILocale ):void {
			_locale = value;
		}
		
	}

}