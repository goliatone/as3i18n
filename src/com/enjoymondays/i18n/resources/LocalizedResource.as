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
package com.enjoymondays.i18n.resources {
	import com.enjoymondays.i18n.core.ILocalizedResource;
	


	/**
	 * <code class="prettyprint">LocalizedResource</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class LocalizedResource implements ILocalizedResource {
		
		/** @private **/
		private var _id								:String;
		
		/** @private **/
		private var _message						:String;
		
		/** @private **/
		private var _data							:Object;
		
		/**
		 * <code class="prettyprint">LocalizedResource</code>
		 * com.enjoymondays.i18n.resources.LocalizedResource		 		
		 * 
		 * @param	id
		 * @param	message
		 * @param	data
		 */
		public function LocalizedResource( id:String, message:String, data:Object = null ) {
			_id = id;
			_message = message;
			_data = data;
		}
		
		/** @inheritDoc **/
		public function hasAttribute( id:String ):Boolean {
			if ( !_data ) return false;
			return _data.hasOwnProperty( id );
		}
		
		/** @inheritDoc **/
		public function getAttribute( id:String ):String {
			if ( !_data ) return null;
			return _data[ id ];
		}
		
		/** @inheritDoc **/
		public function hasData( ):Boolean {
			return _data;
		}
		
		/** @inheritDoc **/
		public function get id( ):String { return _id; }
		
		/** @inheritDoc **/
		public function get message( ):String { return _message; }
		
		/**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		public function toString( ):String {
			return '[ LocalizedResource=> id: ' + _id + ' message: ' + message + ']';
		}
		
	}

}