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
package com.enjoymondays.data.events {
	import flash.events.Event;
	
	/**
	 * HashMapEvent.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos 
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class HashMapEvent extends Event {
		/**
		 * Defines the value of the type property of a add event object.
		 * 
		 * @eventType add
		 */
		public static const ADD							:String = "add";
		
		/**
		 * Defines the value of the type property of a remove event object.
		 * 
		 * @eventType remove
		 */
		public static const REMOVE						:String = "remove";
		
		/**
		 * Defines the value of the type property of a clear event object.
		 * 
		 * @eventType clear
		 */
		public static const CLEAR						:String = "clear";
		
		/**
		 * Defines the value of the type property of a replace event object.
		 * 
		 * @eventType replace
		 */
		public static const REPLACE						:String = "replace";
		
		
		/**
		 * Get the collection index associated with this event.
		 */
		public var key									:*;
		
		/**
		 * Get the collection item associated with this event.
		 */
		public var item									:* ;
		
		/**
		 * HashMapEvent constructor.
		 * 
		 * @param	type	The event type as defined in HashMapEvent constants.
		 * @param	key		The items key in the HashMap.		
		 * @param	item	The HashMap item affected by the event.
		 * 
		 */
		public function HashMapEvent( type:String, key:* = null, item:*=null ) { 
			super( type );
			this.item = item;
			this.key = key;
		} 
		
		/**
		 * @inheritDoc		 
		 */
		public override function clone( ):Event { 
			return new HashMapEvent( type, key, item );
		} 
		
		/**
		 * @inheritDoc		 
		 */
		public override function toString( ):String { 
			return formatToString("HashMapEvent", "type", "key", "item" ); 
		}
		
	}
	
}