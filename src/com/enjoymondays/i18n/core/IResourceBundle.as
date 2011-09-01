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
package com.enjoymondays.i18n.core {
	
	/**
	 * IResourceBundle.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public interface IResourceBundle {
		
		/**
		 *
		 * @param	raw
		 */
		function addRawData( raw:* ):void;
		
		/**
		 *
		 * @param	id
		 * @return
		 */
		function getRawData( ):*;
		
		/**
		 * Returns true if bundle contains a resouce identified by provided key value.
		 * 
		 * @param	key String value used to retrieve resource.
		 * @return	True if this bundle contains a resource identified by the key value.
		 */
		function hasResource( key:String ):Boolean ;
		
		/**
		 * Returns a <code class="prettyprint">ILocalizedResource</code> that holds a specific string value identified
		 * by the provided key string.
		 * 	 
		 * 
		 * @param	key String value used to identify resource.
		 * @return	A ILocalizedResource instance that holds a string value for provided key.
		 */
		function getResource( key:String ):ILocalizedResource ;
		
		/**
		 *
		 * @param	resource
		 */
		function addResource( resource:ILocalizedResource ):void;
		
		/**
		 *
		 * @param	key
		 * @param	message
		 * @param	data
		 */
		function buildResource( key:String, message:String, data:Object = null ):void;
		
		/**
		 *
		 * @param	key
		 * @return
		 */
		function getResourceString( key:String ):String;
		
		/**
		 *
		 * @param	key
		 * @return
		 */
		function hasBundle( key:String ):Boolean ;
		
		/**
		 *
		 * @param	key
		 * @param	bundle
		 */
		function addBundle( key:String, bundle:IResourceBundle ):void;
		
		/**
		 *
		 * @param	key
		 * @return
		 */
		function getBundle( key:String ):IResourceBundle;
		
		/**
		 *
		 * @param	key
		 * @return
		 */
		function getRawBundle( key:String ):*;
		
		
		/**
         * Indicates the id of this bundle object.
         */
		function get id( ):String;
		
		/**
		 * Indicates the Locale of this bundle object.
		 */
		function get lang( ):ILocale;
		
	}
	
}