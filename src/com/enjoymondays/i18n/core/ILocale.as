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
package com.enjoymondays.i18n.core {
	
	/**
	 * <code class="prettyprint">ILocale</code> interface 
	 * that holds information about a locale.
	 * <p>Each ILocale instance represents a localization language,
	 * represented by a two char code, a name and a variant of that name.</p>
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public interface ILocale {
		
		/**
		 * Two char code representing a locale language.
		 * @example
		 * <listing>
		 * var spanish:Locale = Locale.ES;
		 * trace( spanish.code ); // es
		 * </listing>
		 */
		function get code( ):String;
		
		/**
		 * Name of the locale in English.
		 * @example
		 * <listing>
		 * var spanish:Locale = Locale.ES;
		 * trace( spanish.name ); // Spanish
		 * </listing>
		 */
		function get name( ):String;
		
		/**
		 * Name of the locale in it's native language.
		 * @example Type of supported codes:
		 * <listing>
		 * var spanish:Locale = Locale.ES;
		 * trace(spanish.code); // Español
		 * </listing>
		 */
		function get variant():String;
		
	}
	
}