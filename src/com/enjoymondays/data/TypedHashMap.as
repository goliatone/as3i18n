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
	


	/**
	 * <code class="prettyprint">TypedHashMap</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class TypedHashMap extends HashMap {
		
		protected var _type							:Class;
		protected var _typeString					:String;
		
		/**
		 * <code class="prettyprint">TypedHashMap</code>
		 * com.enjoymondays.data.TypedHashMap
		 * 
		 * @param	type
		 */
		public function TypedHashMap( type:Class ) {
			super( );
			//we should check for type not null!!
			_type = type;
			//_typeString = GLoggerDumper.classToString( type );
			_typeString = Object( type ).toString();
		}
		
		public function getType( ):Class {
			return _type;
		}
		
		
		
		/**
		 *
		 * @param	key
		 * @param	value
		 * @return If the key already existed, and had a previous value it will return it.
		 */
		override public function add( key : * , value : * ):* {
			if ( !( value is _type ) ) {
				//_logger.error( "add( ) failed. Value has to be of type %0,", _typeString );
				return value as _type;
			}
			
			if (key != null) {
				
				var oldVal : * = null;
				
				if ( hasKey( key ) ) oldVal = remove( key );
				
				_n++;
				var count : uint = _values[ value ];
				_values[ value ] = (count > 0) ? count+1 : 1;
				_keys[ key ] = value;
				
				return oldVal;
			} else {
				//_logger.error("add( ) failed. Key can't be null" );
				return value as _type;
			}
			
			
		}
		
		/**
		 *
		 */
		override public function get( key:* ):* {
			//if( key == null ) // _logger.error("get( ) failed. Key can't be null" );
			return _keys[ key ] as _type;
		}
		
		
		
		
		
		
		
		/*
		 * FIXME: Find a better way to do this!
		 */
		override public function clone( ):HashMap {
			var c:TypedHashMap = new TypedHashMap( _type );
			var keys:ArrayIterator = new ArrayIterator( getKeys( ) );
			while ( keys.hasNext( ) ) {
				var n:* = keys.next( );
				c.add( n, get( n ) );
			}
			return c;
		}
		
		
		/**
		 * FIXME: Make a proper dump of this object.
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		override public function toString( ):String {
			var s:String = "[ TypedHashMap<"+_typeString+">";
			var c:String = "]";
			var se:String = '';
			
			if ( _n == 0 ) return s + c;
			else {
				se = '=>';
				for ( var key : * in _keys ) se += "\n\t" + key + ":\t" + _keys[ key ];
			}
			return "TypedHashMap dump: \n"+s + se + "\n" + c;
		}
		
		
	}
	
}