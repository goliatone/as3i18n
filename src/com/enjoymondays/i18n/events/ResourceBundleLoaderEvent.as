﻿/**
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
	//import com.enjoymondays.mvc.events.DispachableEvent;
	import flash.events.Event;
	
	
	
	/**
	 *  <p> ResourceBundleLoaderEvent.</p>
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	//public class ResourceBundleLoaderEvent extends DispachableEvent {
	public class ResourceBundleLoaderEvent extends Event {
		
		public static const LOADED				:String = 'onResourceLoaded';
		public static const ERROR				:String = 'onResourceError';
		public var data:*;
		
		
		/**
		 * ResourceBundleLoaderEvent.
		 * com.enjoymondays.i18n.events.ResourceBundleLoaderEvent
		 */
		public function ResourceBundleLoaderEvent(type:String, data:* = null ) {
			super(type, bubbles, cancelable);
			this.data = data
		}
		
		/**
		 * @inheritDoc
		 */
		public override function clone( ):Event {
			return new ResourceBundleLoaderEvent(type, data );
		}
		
		/**
		 * @inheritDoc
		 */
		public override function toString( ):String {
			return formatToString("ResourceBundleLoaderEvent", "type","data" );
		}
		
	}
	
}