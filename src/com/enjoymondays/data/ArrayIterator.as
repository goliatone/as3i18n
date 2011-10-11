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
	 * <code class="prettyprint">ArrayIterator</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class ArrayIterator implements Iterator {
		
		private var _array					:Array;
		private var _size					:int;
		private var _index					:Number;
		private var _removed				:Boolean;
		private var _added					:Boolean;
		
		/**
		 * <code class="prettyprint">ArrayIterator</code>
		 * com.enjoymondays.data.ArrayIterator
		 */
		public function ArrayIterator(  array:Array, index:uint = 0 ) {
			
			if( array == null )	throw new Error( "The target array of " + this + "can't be null" );
			if( index > array.length )	throw new Error ( "The passed-in index " + index + " is not array valid for an array of length " + array.length );
			
			_array 	 = array;
			_size 	 = array.length;
			_index 	 = index ;
			_removed = false;
			_added 	 = false;
			//GLogger.debug("INIT INDEX: " + _index );
		}
		
		public function hasNext( ):Boolean {
			return ( _index  < _size );
	    }
		
		public function next( ):* {
			if( !hasNext( ) )	throw new Error ( this + "::next() has no more elements at " + ( _index  ) );
			
			_removed = false;
			_added = false;
			return _array[ _index++ ];
	    }
		
		public function get size( ):int {
			return _size;
		}
		
		public function reset( ):void {
			_size = _array.length;
			_index = 0;
			_removed = false;
			_added = false;
		}
		
		public function remove( ):* {
			var item:* = null;
			if ( !_removed ) {
				item = _array.splice( --_index, 1 );
				_size--;
				_removed = true;				
			} else	throw new Error ( this + "::remove() have been already called for this iteration" );
			
			return item
		}
		
		public function add( data:Object ):void {
			if ( !_added ) {
				_array.splice( _index, 0, data );
				_size++;
				_added = true;
			} else	throw new Error ( this + "::add( ) have been already called for this iteration" );
			
		}
		
		public function hasPrevious( ):Boolean {
			return _index >= 0;
		}
		
		public function nextIndex( ):uint {
			return _index;
		}
		
		public function previous( ):* {
			if( !hasPrevious() )	throw new Error ( this + "::previous() has no more elements at " + ( _index ) );
			
			_removed = false;
			_added = false;
			
			return _array[ --_index ];
		}
		
		public function previousIndex( ):uint {
			return _index - 1;
		}
		
		public function set( data:Object ):void {
			if ( !_removed && !_added )	_array[ _index ] = data;
			else	throw new Error ( this + ".add() or " + this + ".remove() have been already called for this iteration, the set() operation cannot be done" );
			
		}
		
		public function destroy( ):void {
			_array = null;
			_array = [];
			reset( );
		}
		
		public function toArray( ):Array {
			return _array.concat( );
		}
		
		/**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		public function toString( ):String {
			return "[ArrayIterator]";
			//return GLoggerDumper.classToString( this );
		}
		
	}
	
}