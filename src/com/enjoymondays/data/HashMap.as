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
package com.enjoymondays.data {
	
	import com.enjoymondays.data.events.HashMapEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Dispatch when an item is added to collection.
	 * 
	 * @eventType com.enjoymondays.data.events.HashMapEvent.ADD
     */
    [Event(name="add", type="com.enjoymondays.data.events.HashMapEvent")]
    
    /**
	 * Dispatch when an item is removed from collection.
	 * 
	 * @eventType com.enjoymondays.data.events.HashMapEvent.REMOVE
     */
    [Event(name="remove", type="com.enjoymondays.data.events.HashMapEvent")]
    
    /**
	 * Dispatch when an item is replaced in collection.
	 * 
	 * @eventType com.enjoymondays.data.events.HashMapEvent.REPLACE
     */
    [Event(name="replace", type="com.enjoymondays.data.events.HashMapEvent")]
    
    /**
	 * Dispatch when collection is cleared.
	 * 
	 * @eventType com.enjoymondays.data.events.HashMapEvent.CLEAR
     */
    [Event(name = "clear", type = "com.enjoymondays.data.events.HashMapEvent")]
	
	/**
     * Hash table based implementation of the Map interface.
	 * This implementation provides all of the optional map operations, 
	 * and permits null values and the null key.
	 * 
     * <p>This class makes no guarantees as to the order of the map; 
	 * in particular, it does not guarantee that the order will remain constant over time.
	 * </p>
	 * 
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import com.enjoymondays.data.HashMap;
     * import com.enjoymondays.data.Iterator;
     * 
     * var map:Map = new HashMap() ;
     * 
     * trace("add key1 -> value0 : " + map.add("key1", "value0") ) ;
     * trace("add key1 -> value1 : " + map.add("key1", "value1") ) ;
     * trace("add key2 -> value2 : " + map.add("key2", "value2") ) ;
     * trace("add key3 -> value3 : " + map.add("key3", "value3") ) ;
     * 
     * trace("map : " + map) ;
     * 
     * trace("--- clone") ;
     * 
     * var clone:HashMap = map.clone() ;
     * trace("clone : " + clone) ;
     * 
     * trace("--- iterator") ;
     * 
     * var it:Iterator = map.iterator() ;
     * while( it.hasNext() )
     * {
     *     var v:* = it.next() ;
     *     var k:* = it.key() ;
     *     trace( "   -> " + k + " : " + v ) ;
     * }
     * 
     * trace("--- remove 'key1'") ;
     * 
     * trace("remove key1 : " + map.remove("key1")) ;
     * 
     * trace("size : " + map.size()) ;
     * 
     * trace("map : " + map) ;
     * 
     * trace("--- clear and isEmpty") ;
     * 
     * map.clear() ;
     * 
     * trace("isEmpty : " + map.isEmpty()) ;  
     * </pre>
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.paginaswebflash.com
	 *  @version 	 1.0
	 */
	public class HashMap extends EventDispatcher {
		
		protected var _n					:uint;
		protected var _keys					:Dictionary;
		protected var _values				:Dictionary;
		
		/**
		 * <code class="prettyprint">HashMap</code>
		 * as3-i18n.source.com.enjoymondays.data.HashMap
		 */
		public function HashMap() {
			_init( );
		}
		
		/** @private */
		protected function _init( ):void {
			//_logger = Logger.instance( this );
			_keys 	= new Dictionary( true );
			_values = new Dictionary( true );
			_n = 0;
		}
		
		/**
         * Removes all mappings from this map.
         */  
		public function clear( ):void {
			_init( );
			//ADDED 17/01/2011 11:02
			_notify( HashMapEvent.CLEAR );
		}
		
		/**
         * Returns true if this map contains no key-value mappings.
         * @return true if this map contains no key-value mappings.
         */
		public function isEmpty( ):Boolean {
			return ( _n == 0 );
		}
		
		/**
         * Returns true if this map contains a mapping for the specified key.
		 * @param 	key Any object used as key 
         * @return 	true if this map contains a mapping for the specified key.
         */
		public function hasKey( key : * ) : Boolean {
			//if ( key == null ) _logger.error("hasKey( ) failed. Key can't be null" );
			
			return _keys[ key ] != null;
		}
		
		/**
		 * Returns true if this map maps one or more keys to the specified value.
		 * Remember that a  HashMap may have different keys
		 * containing the same value, so that the content 
		 * might not be the one for the expected key.
		 * @param	value Any object that could be stored in this map.
         * @return 	true if this map maps one or more keys to the specified value.
         */
		public function hasValue( value : * ) : Boolean {
			return _values[ value ] != null;
		}
		
		/**
         * Associates the specified value with the specified key in this map.
		 *
		 * Dispatches a HashMapEvent.ADD
		 * @param	key
		 * @param	value
		 * @return If the key already existed, and had a previous value it will return it.		 
		 */
		public function add( key : * , value : * ):* {
			if (key != null) {
				
				var oldVal : * = null;
				
				if ( hasKey( key ) ) {
					oldVal = _remove( key, false );
					//ADDED 17/01/2011 11:06
					_notify( HashMapEvent.REPLACE, key, oldVal );
				}
				
				_n++;
				var count : uint = _values[ value ];
				_values[ value ] = (count > 0) ? count+1 : 1;
				_keys[ key ] = value;
				
				//ADDED 17/01/2011 11:06
				_notify( HashMapEvent.ADD, key, value );
				
				return oldVal;
			} else {
				//_logger.error("add( ) failed. Key can't be null" );
				return value;
			}
		}
		
		 /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
		public function get( key:* ):* {
			//if( key == null )	_logger.error("get( ) failed. Key can't be null" );
			return _keys[ key ];
		}		
		
		/**
         * Removes the mapping for the provided key from this map if present.
         * @param 	key The key whose mapping is to be removed from the map.
         * @return 	previous value associated with specified key, or null if there was no mapping for key. A null return can also indicate that the map previously associated null with the specified key.
         */
		public function remove( key:* ):* {
			return _remove( key );
		}		
		
		/**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */
		public function size( ) : Number { return _n; }
		
		/**
         * Returns an array representation of all keys in the map.
         * @return an array representation of all keys in the map.
         */
		public function getKeys( ):Array {
			var a : Array = new Array();
			for ( var key : * in _keys ) a.push( key );
			return a;
		}
		
		/**
         * Returns an array representation of all values in the map.
         * @return an array representation of all values in the map.
         */
		public function getValues( ) : Array {
			var a : Array = new Array();
			for each ( var value : * in _keys ) a.push( value );
			return a;
		}
		
		/**
		 *
		 * @param	f
		 */
		public function walkValues( f:Function ):void {
			for each ( var value: * in _keys ) f( value );
		}
		
		/**
		 *
		 * @param	f
		 */
		public function walkKeys( f:Function ):void {
			for ( var key : * in _keys ) f( key );
		}
		
		/**
		 * FIXME: Find a better way to do this!
		 * 
         * Returns a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         * @return a shallow copy of this HashMap instance: the keys and values themselves are not cloned.
         */
		public function clone( ):HashMap {
			var c:HashMap = new HashMap( );
			var keys:ArrayIterator = new ArrayIterator( getKeys( ) );
			while ( keys.hasNext( ) ) {
				var n:* = keys.next( );
				c.add( n, get( n ) );
			}
			return c;
		}
		
		
		/**
		 * ADDED 17/01/2011 11:06
		 * @param	key
		 * @param	notify
		 * @return
		 * @private
		 */
		protected function _remove( key:*, notify:Boolean = true ):* {
			var value : *;
			
			if ( hasKey( key ) ) {
				_n--;
				value = _keys[ key ];
				
				var count : uint = _values[ value ];
				if (count > 1) _values[ value ] = count - 1;
				else delete _values[ value ];
				
				delete _keys[ key ];
				
				if( notify ) _notify( HashMapEvent.REMOVE, key, value );
			}
			
			return value;
		}
		
		/**
		 * 
		 * @param	type
		 * @param	key
		 * @param	value
		 * @private
		 */
		protected function _notify( type:String, key:*= null, value:*= null ):void {
			if ( hasEventListener( type ) ) dispatchEvent( new HashMapEvent( type, key, value ) );
		}
		
		/**
		 * FIXME: Make a proper dump of this object.		
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		override public function toString( ):String {
			var s:String = "[ HashMap ";
			var c:String = "]";
			var se:String = '';
			
			if ( _n == 0 ) return s + c;
			else {
				se = '=>';
				for ( var key : * in _keys ) se += "\n\t" + key + ":\t" + _keys[ key ];
			}
			return "HashMap dump: \n"+s + se + "\n" + c;
		}		
	}
	
}