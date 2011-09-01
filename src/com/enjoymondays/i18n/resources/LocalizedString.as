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
	
	import com.enjoymondays.i18n.LocalizationManager;	
	import com.enjoymondays.core.interfaces.IDestroyable;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	* Dispatched after the LocalizationManager updates and 
	* the value of this items id was found.
	*
	* @eventType Event.CHANGE
	*/
	[Event(name = "change", type = "flash.events.Event")]
	
	/**
	 *  LocalizedString.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class LocalizedString extends EventDispatcher implements IDestroyable {
		
		/** @private **/
		//private var _logger				:Logger = Logger.instance( LocalizedString );
		
		/** @private **/
		private var _id					:String;
		
		/** @private **/
		private var _bundleId			:String;
		
		/** @private **/
		private var _value				:String;
		
		/** @private **/
		private var _manager			:LocalizationManager;
		
		/** @private **/
		private var _setter				:Function;
		
		/** @private **/
		private var _pending			:Boolean = false;
		
		
		/**
		 * 
		 * @param	stringId
		 * @param	setter
		 */
		public function LocalizedString( stringId:String = '', setter:Function = null ) {
			super( );
			
			if ( stringId != '' ) this.id = stringId;
			if ( setter != null ) _setter = setter;
			
			//_logger.warn("LocalizedString created with id: %0", stringId );
			
			_init( );
		}
		
		/**
		 * @private
		 */
		private function _init( ):void {
			//_logger.info("localized string init");
			_manager = LocalizationManager.instance;
			_manager.addEventListener( "onLangUpdateAvailable" , _updateString );
			requestUpdate( );
		}
		
		/**
		 * REVISION If we have id inside a bundle, then we can't drill down to see if its contained.
		 * We should perhaps add a bundleId on the constructor, or implement a deep search on ResourceBundle.
		 *
		 * @param	e
		 * @private
		 */
		private function _updateString( e:Event = null ):void {
			if ( _manager.currentBundle.hasResource( identifier ) ) {
				_value = _manager.currentBundle.getResourceString( identifier );
				if ( hasEventListener( Event.CHANGE ) ) dispatchEvent( new Event( Event.CHANGE ) );
				if ( _setter != null ) _setter( _value );
				//_logger.delimiter( );
				//_logger.delimiter( );
				//_logger.delimiter( );
				//_logger.delimiter( );
				//_logger.info( "Localized string %0 has new value: %1", identifier, value );
				_pending = false;
				return;
			}
			//_logger.warn( "We have an udpate of locale, but not with id => %0", identifier );
		}
		
		/*private function _updateString( e:Event = null ):void {
			if ( _manager.hasResource( _id ) ) {
				_value = _manager.currentBundle.getResourceString( _id );
				if ( hasEventListener( Event.CHANGE ) ) dispatchEvent( new Event( Event.CHANGE ) );
				if ( _setter != null ) _setter( _value );
				
				_logger.info( "Localized string %0 has new value: %1", id, value );
				_pending = false;
				return;
			} else if(  _manager.currentBundle.getBundle( 'urlRewrite' ).hasResource( _id ) ) {
				_value = _manager.currentBundle.getBundle( 'urlRewrite' ).getResourceString( _id );
				if ( hasEventListener( Event.CHANGE ) ) dispatchEvent( new Event( Event.CHANGE ) );
				if ( _setter != null ) _setter( _value );
				
				_logger.info( "Localized string %0 has new value: %1", id, value );
				_pending = false;
				return;
			}
			_logger.warn( "We have an udpate of locale, but not with id => %0", _id );
		}*/
		
		/**
		 *
		 */
		public function requestUpdate( ):void {
			if ( !_manager ) _init( );
			if ( ! _manager.localeAvailable ) {
				_pending = true;
				//_logger.fatal( "request update pending!" );
				return //here we should force to get notified later!!
			}
			_updateString( );
		}
		
		/* INTERFACE com.enjoymondays.mvc.core.interfaces.IDestroyable */
		
		public function destroy( ):void {
			_manager.removeEventListener( "onLangUpdateAvailable" , _updateString );
			_setter = null;
		}
		
		
		/**
		 * Identifier differs from id in the following:
		 * If we have a bundleId we compose the identifier such as
		 * identifier = bundleId + / + id;
		 * Else we return id.
		 * 
		 * We use it to access nested resources such as "urlRewrite/HomePage".
		 * 
		 */
		public function get identifier( ):String {	
			if ( _bundleId ) return _bundleId + '/' + _id;
			else return _id;
			
		}		
		
		/**
		 * 
		 */
		public function get id( ):String { return _id; }
		/** @private */
		public function set id( id:String ):void {
			if ( _id == id ) return;
			_id = id;
		}
		
		/**
		 * 
		 */
		public function get bundleId():String { return _bundleId; }
		/** @private */
		public function set bundleId(value:String):void {
			_bundleId = value;
		}
		
		/**
		 *
		 */
		public function get value( ):String { return _value; }
		
		
		/**
		 * 
		 */
		public function get pending():Boolean { return _pending; }
		
	}
}