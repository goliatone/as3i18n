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
package com.enjoymondays.i18n {
	


	/**
	 * <code class="prettyprint">LocalizationStatus</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class LocalizationStatus {
		
		/**
		 *
		 */
		public static const INITIALIZING							:String = 'INITIALIZING';
		
		/**
		 *
		 */
		public static const READY									:String = 'READY';
		
		/**
		 *
		 */
		public static const UPDATE_REQUESTED						:String = 'UPDATE_REQUESTED';
		
		/**
		 *
		 */
		public static const SAME_LOCALE_REQUEST						:String = 'SAME_LOCALE_REQUEST';
		
		/**
		 *
		 */
		public static const BAD_LOCALE_REQUEST						:String = 'BAD_LOCALE_REQUEST';
		
		/**
		 *
		 */
		public static const REQUEST_NOT_SUPPORTED					:String = 'REQUESTED_LOCALE_NOT_SUPPORTED';
		
		/**
		 * <code class="prettyprint">LocalizationStatus</code>
		 * com.enjoymondays.i18n.LocalizationStatus
		 */
		public function LocalizationStatus() {
			
		}
		
	}

}