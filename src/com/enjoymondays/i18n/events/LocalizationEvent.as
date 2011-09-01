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
package com.enjoymondays.i18n.events {
	import com.enjoymondays.i18n.core.ILocale;
	//import com.enjoymondays.mvc.events.DispachableEvent;
	import flash.events.Event;
	
	
	
	/**
	 *  <p> LocalizationEvent.</p>
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	//public class LocalizationEvent extends DispachableEvent {
	public class LocalizationEvent extends Event {
		
		/**
		 * 
		 */
		public static const UPDATE_REQUEST			:String = 'onLangUpdateRequest';
		
		/**
		 * 
		 */
		public static const UPDATE_AVAILABLE		:String = 'onLangUpdateAvailable';
		
		/**
		 * 
		 */
		public static const UPDATE_ERROR			:String = 'onLangUpdateError';
		
		/**
		 * 
		 */
		public static const LANG_UPDATE				:String = 'onSupportedLangsUpdate';
		
		/**
		 * 
		 */
		public var lang								:ILocale;
		
		/**
		 * LocalizationEvent.
		 * com.enjoymondays.i18n.events.LocalizationEvent
		 */
		public function LocalizationEvent( type:String, lang:ILocale = null ) {
			super(type);
			this.lang = lang;
		}
		
		/**
		 * @inheritDoc
		 */
		public override function clone( ):Event {
			return new LocalizationEvent( type, lang );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function toString( ):String {
			return formatToString("LocalizationEvent", "type","data", "lang" );
		}
		
	}
	
}