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
package com.enjoymondays.i18n.providers.loaders {
	
	
	import com.enjoymondays.i18n.core.IResourceBundleLoader;
	import com.enjoymondays.i18n.ResourceBundleVO;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	


	/**
	 * <code class="prettyprint">AbstractResourceBundleLoader</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class AbstractResourceBundleLoader extends EventDispatcher implements IResourceBundleLoader {
		
		/** @private **/
		protected var _vo							:ResourceBundleVO;
		
		/** @private **/
		protected var _data							:*;
		
		/**
		 * <code class="prettyprint">AbstractResourceBundleLoader</code>
		 * com.enjoymondays.i18n.providers.loaders.AbstractResourceBundleLoader
		 */
		public function AbstractResourceBundleLoader( ) {
			
		}
		
		/** @inheritDoc */
		public function load( vo:ResourceBundleVO ):void { }
		
		
		/** @inheritDoc */
		public function getRawdata( ):* {
			return _data;
		}
		
		
		
	}

}