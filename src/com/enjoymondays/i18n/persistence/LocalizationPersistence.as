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
package com.enjoymondays.i18n.persistence {
	
	//import com.enjoymondays.logging.Logger;
	import com.enjoymondays.i18n.Locale;
	import com.enjoymondays.i18n.core.ILocale;
	
	
	import flash.net.SharedObject;
	


	/**
	 * <code class="prettyprint">LocalizationPersistence</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class LocalizationPersistence {
		
		private static const OBJECT_ID					:String = '__locale__persitence__';
		
		//private var _logger								:Logger = Logger.instance( LocalizationPersistence );
		
		private var _status								:String;
		
		
		/**
		 * <code class="prettyprint">LocalizationPersistence</code>
		 * com.enjoymondays.i18n.persistence.LocalizationPersistence
		 */
		public function LocalizationPersistence() { }
		
		/**
		 *
		 * @param	locale
		 * @return	String — Either of the following values:
		 * 					 SharedObjectFlushStatus.PENDING: The user has permitted local information storage for
		 * 					 objects from this domain, but the amount of space allotted is not sufficient to store the object.
		 * 					 Flash Player prompts the user to allow more space. To allow space for the shared object to grow
		 *					 when it is saved, thus avoiding a SharedObjectFlushStatus.PENDING return value, pass a value for minDiskSpace.
		 *
		 * 					 SharedObjectFlushStatus.FLUSHED: The shared object has been successfully written to a file on the local disk.
		 */
		public function saveLocale( locale:ILocale ):String {
			//_logger.warn( "We are storing locale data, %0", locale.code );
			
			var localeData:Object = { code: locale.code };
			var lso:SharedObject = SharedObject.getLocal( OBJECT_ID );
			lso.data.locale = localeData;
			_status = lso.flush( );
			return _status;
		}
		
		/**
		 *
		 * @param	fallback
		 * @return
		 */
		public function readLocale( fallback:ILocale ):ILocale {
			var lso:SharedObject = SharedObject.getLocal( OBJECT_ID );
			var locale:Object = lso.data.locale;
			
			if ( locale != null) {
				//_logger.warn( "We are reading locale data, %0", locale.code );
				return Locale.get( locale.code );
			} else return fallback;
			
		}
		
		/**
		 *
		 */
		public function clearLocale(  ):void {
			var lso:SharedObject = SharedObject.getLocal( OBJECT_ID );
			lso.clear();
		}
		
		/**
		 *
		 */
		public function get status():String { return _status; }
		
	}

}