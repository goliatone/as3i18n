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
	
	import com.enjoymondays.data.TypedHashMap;	
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.i18n.core.IResourceBundle;
	import com.enjoymondays.i18n.core.ILocalizedResource;
	import com.enjoymondays.i18n.resources.LocalizedResource;
	
	/**
	 * REVISION Add nested retrieval by notation, i.e. getResource("urlRewrite/HomePage")
	 * 
     * Concrete implementation of the <code class="prettyprint">IResourceBundle</code> interface.
     * <p><b>Example :</b></p>
	 * <listing>
	 * import com.enjoymondays.i18n.Locale;
	 * import com.enjoymondays.i18n.LocalizationManager;
	 * import com.enjoymondays.i18n.core.IResourceBundle;
	 * import com.enjoymondays.i18n.core.ILocalizedResource;
	 * 
	 * var resourceId:String = "helloBtn";
	 * var bundle:IResourceBundle = LocalizationManager.instance.getLocaleBundle( Locale.ES );
	 * var resource:ILocalizedResource = bundle.getResource( resourceId );
	 * trace( "message is :", resource.message ); // ¡Hola!
	 * </listing>
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class ResourceBundle implements IResourceBundle {
		
		/** @private **/
		private var _lang						:ILocale;
		
		/** @private **/
		private var _id							:String;
		
		/** @private **/
		private var _bundle						:TypedHashMap;
		
		/** @private **/
		private var _groups						:TypedHashMap;
		
		/** @private **/
		private var _rawbundle					:*;
		
		//private var _logger						:Logger = Logger.instance( ResourceBundle );
		
		/**
		 * <code class="prettyprint">ResourceBundle</code>
		 * com.enjoymondays.i18n.ResourceBundle
		 */
		public function ResourceBundle( id:String = null, locale:ILocale = null ) {
			_lang = locale;
			_id = id;
			_bundle = new TypedHashMap( LocalizedResource );
			_groups = new TypedHashMap( ResourceBundle );
		}
		
		/**
		 *
		 * @param	key
		 * @return
		 */
		public function hasResource( key:String ):Boolean {
			if ( ! key ) {
				//_logger.warn("we are trying to verify a resource with null key.");
				return false;
			}
			/*
			 * Support for nested accessing of bundles with 
			 * syntax: "urlRewrite/HomePage"
			 */ 
			if ( key.indexOf("/") != -1 ) {
				var keys:Array = key.split('/');
				var bundleId:String = keys[0];
				var bundledKey:String = keys[1];
				if ( ! _groups.hasKey( bundleId ) ) return false;
				var bundle:IResourceBundle = _groups.get( bundleId );				
				return bundle.hasResource( bundledKey );				
			}
			
			return _bundle.hasKey( key );
		}
		
		/** @inheritDoc */
		public function getResource( key:String ):ILocalizedResource {
			if ( ! key ) {
				//_logger.warn("we are trying to get a resource with null key.");
				return null;
			}
			/*
			 * Support for nested accessing of bundles with 
			 * syntax: "urlRewrite/HomePage"
			 */ 
			if ( key.indexOf("/") != -1 ) {
				var keys:Array = key.split('/');
				var bundleId:String = keys[0];
				var bundledKey:String = keys[1];
				if ( ! _groups.hasKey( bundleId ) ) return null;
				var bundle:IResourceBundle = _groups.get( bundleId );
				
				if ( ! bundle.hasResource( bundledKey ) ) return null;
				
				return bundle.getResource( bundledKey );				
			}
			
			return _bundle.get( key ) as ILocalizedResource;
		}
		
		/** @inheritDoc */
		public function getResourceString( key:String ):String {
			
			if ( ! key ) {
				//_logger.warn("we are trying to get a resource string with null key.");
				return null;
			}
			
			/*
			 * Support for nested accessing of bundles with 
			 * syntax: "urlRewrite/HomePage"
			 */ 
			if ( key.indexOf("/") != -1 ) {
				var keys:Array = key.split('/');
				var bundleId:String = keys[0];
				var bundledKey:String = keys[1];
				if ( ! _groups.hasKey( bundleId ) ) return null;
				var bundle:IResourceBundle = _groups.get( bundleId );
				
				if ( ! bundle.hasResource( bundledKey ) ) return null;
				
				return bundle.getResourceString( bundledKey );				
			}
			
			return _bundle.get( key ).message;
		}
		
		/** @inheritDoc */
		public function addResource( resource:ILocalizedResource ):void {
			//_logger.fatal("adding resource to bundle %0 with id %1",_id, resource.id );
			_bundle.add( resource.id, resource );
		}
		
		/** @inheritDoc */
		public function buildResource( key:String, message:String, data:Object = null ):void {
			//_logger.fatal("build resource to bundle %0 with id %1",_id, key );
			_bundle.add( key, new LocalizedResource( key, message, data ) );
		}
		
		/** @inheritDoc */
		public function hasBundle( key:String ):Boolean {
			return _groups.hasKey( key );
		}
		
		/** @inheritDoc */
		public function addBundle( key:String, bundle:IResourceBundle ):void {
			_groups.add( key, bundle );
		}
		
		/** @inheritDoc */
		public function getBundle( key:String ):IResourceBundle {
			return _groups.get( key );
		}
		
		/** @inheritDoc */
		public function getRawBundle( key:String ):* {
			return IResourceBundle( _groups.get( key ) ).getRawData( );
		}
		
		/** @inheritDoc */
		public function addRawData(raw:* ):void {
			//_logger.warn("ADDING RAW DATA!: %0", raw );
			_rawbundle = raw;
		}
		
		/** @inheritDoc */
		public function getRawData( ):* {
			return _rawbundle;
		}
		
		/** @inheritDoc */
		public function get id():String { return _id; }
		
		/** @inheritDoc */
		public function get lang():ILocale { return _lang; }
		
		public function get bundleKeys( ):Array { return _bundle.getKeys( ) }
		public function get bundleValues( ):Array { return  _bundle.getValues( ) }
		
	}

}