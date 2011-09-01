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
	
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.data.HashMap;
	import com.enjoymondays.core.interfaces.IComparable;
	


	/**
	 * <code class="prettyprint">Locale</code> is an ISO 639-2 code representing a language.
	 * We provide a two characters that represent the language, a name in English and a name variant
	 * in the provided language.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class Locale implements ILocale, IComparable {
		
		/** @private */
		public static var LOCALES					:HashMap = new HashMap( ) ;
		
		/*
		 * List of ISO 639-2 codes
		 */
			
		/** Catalan locale. */
        public static const CA					:Locale = new Locale( "ca", "Catalan", "Catalan" );
		
		/** German locale. */
        public static const DE					:Locale = new Locale( "de", "German", "German" );
		
		/** English locale. */
        public static const EN					:Locale = new Locale( "en", "English", "English" );
		
		/** Spanish locale. */
        public static const ES					:Locale = new Locale( "es", "Spanish", "Castellano" );
		
		/** Dutch locale. */
        public static const NL					:Locale = new Locale( "nl", "Dutch", "Dutch" );
		
		/** French locale.  */
        public static const FR					:Locale = new Locale( "fr", "French", "French" );
		
		/** Unknow locale. */
        public static const XU					:Locale = new Locale( "xu", "Other/unknown" );
		
		
		/** @private */
		private var _code						:String;
		
		/** @private */
		private var _name						:String;
		
		/** @private */
		private var _variant					:String;
		
		
		/**
         * Creates a new Locale instance.
         *
         * @param name
		 * <code class="prettyprint">Locale</code>
		 * com.enjoymondays.i18n.Locale
		 *
		 * @param code The locale language specified as a lowercase two-letter language code from ISO 639-1.
		 * For Chinese, an additional uppercase two-letter country code from ISO 3166 distinguishes between Simplified and Traditional Chinese.
		 * @param	name	The English names of the language.
		 * @param	variant	The native name of the language.
		 */
		public function Locale( code:String, name:String, variant:String = null ) {
			_code = code;
			_name = name;
			_variant = variant;
			
			add( this ) ;
        }
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// STATIC METHODS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
        /**
         * We pass a Locale code string and we get the related Locale instance.
		 * If the provided string code has no related Locale, then null is returned.
		 *
         * @param	code String
         * @return  Locale
         */
        public static function get( code:String ):Locale {
			return LOCALES.get( code ) //|| Locale.XU;
		}
		
		/**
		 * Add a Locale instance to the LOCALES HashMap.
		 * @param	locale
		 * @return
		 */
        public static function add( locale:Locale ):* {
			return LOCALES.add( locale.code , locale ) ;
		}
		
		/**
		 * Remove a Locale instance from the LOCALES HashMap
		 * @param	locale
		 * @return
		 */
        public static function remove( locale:Locale ):* {
			return LOCALES.remove( locale.code ) ;
		}
		
		/**
		 * Returns the number of locales in the HashMap.
		 * @return	uint
		 */
        public static function size( ):uint {
			return LOCALES.size( ) ;
		}
		
		/**
		 * We can pass a code string and get the corresponding Locale
		 * @param	locale	String or Locale
		 * @return	Locale
		 */
        public static function convert( item:* ):Locale {
			var locale:Locale = null;
			if ( item is String ) locale = get( item );
			if ( item is Locale ) locale = item;
			
			return locale;
		}
		
        /**
         * Locale can be either a String or a Lan instance. Anything else will return false.
		 * It will check the LOCALES <code class="prettyprint">HashMap</code> to see if the key is contained.
		 *
         * @param	locale	String or Locale
         * @return	False	If is not a Locale or a String, and if is not on the LOCALES <code class="prettyprint">HashMap</code>
         */
        public static function isValid( locale:* ):Boolean {
            var s:String ;
            if ( locale is Locale ) s = Locale(locale).code ;
            else if ( locale is String ) s = String(locale).toLowerCase() ;
            else return false ;
            return LOCALES.hasKey( s );
        }
		
		/**
		 * Same as isValid but negated.
		 *
		 * @see 	com.enjoymondays.i18n.Locale#isValid()
		 * @param	locale
		 * @return  Boolean
		 */
        public static function notValid( locale:* ) :Boolean {
			return !isValid( locale );
		}
		
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PUBLIC METHODS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Compares two Locale's by code.
		 * REVISION Should be accept Strings as well?
		 * @param	to
		 * @return  Boolean
		 */
		public function equals(to:*):Boolean {
			if ( to == null ) return false;
			if ( ! to is Locale ) return false;
			return this.code == Locale(to).code? true : false;
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GETTERS & SETTERS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/** @inheritDoc */
		public function get code( ):String { return _code; }
		
		/** @inheritDoc */
		public function get name( ):String { return _name; }
		
		/** @inheritDoc */
		public function get variant( ):String { return _variant; }
		
		
		/**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		public function toString():String {
			return "[Locale => code: " + code+ ", name: " + name + ", variant: " + variant + "]";
        }
	}

}