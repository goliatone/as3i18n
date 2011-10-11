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
	import com.enjoymondays.i18n.core.ILocalizationManager;
	import com.enjoymondays.i18n.core.ILocalizedResource;
	import com.enjoymondays.i18n.core.IResourceBundle;
	import com.enjoymondays.i18n.core.IResourceBundleProvider;
	import com.enjoymondays.i18n.core.IResourceBundleProviderFactory;
	import com.enjoymondays.i18n.core.IResourceBundleProviderManager;
	import com.enjoymondays.i18n.events.LocalizationEvent;
	import com.enjoymondays.i18n.events.ResourceBundleLoaderEvent;
	import com.enjoymondays.i18n.persistence.LocalizationPersistence;
	import com.enjoymondays.i18n.providers.DefaultProviderManager;
	import com.enjoymondays.i18n.providers.DefaultProviderFactory;
	import com.enjoymondays.utils.fixArguments;
	
	
	import com.enjoymondays.data.TypedHashMap;
	import com.enjoymondays.core.interfaces.IComparable;
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Event dispatched after an error in a locale update.
	 */
	[Event(name = "onLangUpdateError", type = "com.enjoymondays.i18n.events.LocalizationEvent")]
	
	/**
	 * Event dispatched when a requested locale was found, loaded and it's ready to be used.
	 */
	[Event(name = "onLangUpdateAvailable", type = "com.enjoymondays.i18n.events.LocalizationEvent")]
	
	/**
	 * Event dispatched when a request for a new locale is issued and before is ready to be used.
	 */
	[Event(name = "onLangUpdateRequest", type = "com.enjoymondays.i18n.events.LocalizationEvent")]
	

	/**
	 * <code class="prettyprint">LocalizationManager</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class LocalizationManager extends EventDispatcher implements ILocalizationManager {
		
		/**
		 * 
		 */
		static public const VERSION						:String = "v0.1Beta";
		
		
		
		/** @private **/
		static private var _oLM							:LocalizationManager;
		
		/**
		 *
		 */		
		static public const DEFAULT_LOCALE				:Locale = Locale.ES;
		
		
		//** @private */
		//private var _logger								:Logger = Logger.instance( LocalizationManager );
		
		
		/** @private */
		private var _resources							:TypedHashMap;
		
		/** @private */
		private var _resourceBundle						:IResourceBundle;
		
		/** @private */
		private var _localeSupport						:Dictionary;
		
		/** @private */
		private var _locale								:ILocale //= DEFAULT_LOCALE;
		
		/** @private */
		private var _oldLocale							:ILocale;
		
		/** @private */
		private var _providerStrategy					:IResourceBundleProviderManager;
		
		/** @private */
		private var _persistence						:LocalizationPersistence;
		
		/** @private */
		private var _persistent							:Boolean = false;
		
		/** @private */
		private var _ready								:Boolean = false;
		
		/** @private */
		private var _initialized						:Boolean = false;		
		
		/**
		 * <code class="prettyprint">LocalizationManager</code>
		 * com.enjoymondays.i18n.LocalizationManager
		 */
		public function LocalizationManager( ) {
			
			_resources		 = new TypedHashMap( ResourceBundle );
			_localeSupport	 = new Dictionary;
			_persistence	 = new LocalizationPersistence;
			
			setProviderStrategy( new DefaultProviderManager, new DefaultProviderFactory )
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// STATIC METHODS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 * Static method accessor that returns the same instance on each call.
		 * @return LocalizationManager
		 */
		static public function get instance( ):LocalizationManager {
			if ( _oLM ) return _oLM;
			_oLM = new LocalizationManager( );
			return _oLM;
		}
		
		/**
		 * REVISION call to instance initialize method. Pass an IValueObject as only parameter.
		 *
		 * @param	locale
		 * @param	...supportedCodes
		 * @return	LocalizationManager The instance is initialized and ready to use.
		 */
		static public function initialize( locale:ILocale = null, ...supportedCodes ):LocalizationManager {
			instance.initialize( locale, fixArguments( supportedCodes ) );
			return instance;
		}
		
		/**
		 * Returns the default locale. We can provide a ILocale, if we do, we override DEFAULT_LOCALE
		 * and return that locale. If we dont provide a ILocale or we provide null, then we return DEFAULT_LOCALE.
		 * DEFAULT_LOCALE is <code class="prettyprint">Locale.ES</code>
		 * @param	locale
		 * @return	ILocale
		 */
		static public function getDefaultLocale( locale:ILocale = null ):ILocale {
			return locale || DEFAULT_LOCALE;
		}
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PUBLIC METHODS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/** @inheritDoc **/ 
		public function initialize( locale:ILocale = null, ...supportedLocales ):void {
			
			/*
			 * check if localization is configured as persistent and
			 * if there is a supported locale found in the LSO
			 */ 
			if ( _initialized ) return ;// _logger.error("We already had initialized LocalizationManager");
			
			
			
			if ( supportedLocales && supportedLocales.length > 0 ) addSupporetedCodes( fixArguments(supportedLocales) );
			else addSupportedLocale( DEFAULT_LOCALE );
			
			locale = getDefaultLocale( locale );
			
			var currentLocale:ILocale = locale;
			
			/*
			 * we check if we have persistence 
			 * and if the provided locale is not default one.
			 */ 
			if( _persistent && locale != DEFAULT_LOCALE ) {
				locale =  _persistence.readLocale( locale );
				if ( notSupportedLocale( locale ) ){
					//_logger.warn("The persisted Locale ( %0 ) is not supported", locale.code );
				} else {
					//_logger.warn("Using persistent Locale ( %0 ) from previous session", locale.code );
					currentLocale = locale;
				}
				
			}
			
			setCurrentLocale( currentLocale );
			_initialized = true;
		}
		
		/** @inheritDoc **/ 
		public function setProviderStrategy( strategy:IResourceBundleProviderManager, factory:IResourceBundleProviderFactory = null ):void {
			_providerStrategy = strategy;
			_providerStrategy.setOwner( this );
			if( factory ) _providerStrategy.setFactory( factory );
		}
		
		/** @inheritDoc **/ 
		public function getProviderStrategy( ):IResourceBundleProviderManager {
			return _providerStrategy;
		}		
		
		/** @inheritDoc **/ 
		public function setCurrentLocale( locale:ILocale ):String {
			
			if ( Locale.notValid( locale ) ) return LocalizationStatus.BAD_LOCALE_REQUEST;
			if ( IComparable(locale ).equals( _locale ) ) return LocalizationStatus.SAME_LOCALE_REQUEST;
			if ( ! isSupportedLocale( locale ) ) return LocalizationStatus.REQUEST_NOT_SUPPORTED;
			
			_oldLocale 	= _locale;
			_locale 	= locale;
			
			dispatchEvent( new LocalizationEvent( LocalizationEvent.UPDATE_REQUEST, locale ) );
			//_logger.info( "Set current locale to %0", locale.name );
			
			_updateLangResources( );
			
			return LocalizationStatus.UPDATE_REQUESTED;
		}
		
		/** @inheritDoc **/ 
		public function getCurrentLocale( ):ILocale { return _locale; }		
		
		/** @inheritDoc **/ 
		public function hasResource( key:String ):Boolean {
			return _resourceBundle.hasResource( key );
		}
		
		/** @inheritDoc **/ 
		public function getResource( key:String ):ILocalizedResource {
			return _resourceBundle.getResource( key );
		}
		
		
		/** @inheritDoc **/ 
		public function hasLocaleBundle( id:String ):Boolean {
			return _resources.hasKey( id );
		}
		
		/** @inheritDoc **/ 
		public function getLocaleBundle( id:String ):IResourceBundle {
			return _resources.get( id );
		}	
		
		/** @inheritDoc **/ 
		public function isSupportedLocale( loc:* ) : Boolean {
			var locale:ILocale = Locale.convert( loc );
			if ( !locale ) return false;
			return ( _localeSupport[ locale.code ] != undefined );
		}
		
		/** @inheritDoc **/ 
		public function notSupportedLocale( loc:* ):Boolean {
			var locale:ILocale = Locale.convert( loc );
			if ( !locale ) return true;
			return ( _localeSupport[ locale.code ] == undefined );
		}
		
		/** @inheritDoc **/ 
		public function addSupporetedCodes( ...langs ):void {
			langs = fixArguments( langs );
			for ( var i:int = 0; i < langs.length; i++) {
				addSupportedLocale( langs[i] );
			}
		}		
		
		/** @inheritDoc **/ 
		public function addSupportedLocale( loc:* ) : void {
			var locale:ILocale = Locale.convert( loc );
			if ( !locale ) return;
			
			if ( _localeSupport[ locale.code ] ) return;
			
			_localeSupport[ locale.code ] = locale;
			
			//_logger.info( "Add supported locale %0", locale.name );
		}
		
		
		/**
		 *
		 * @param	e
		 * @private
		 */
		/** @inheritDoc **/ 
		public function onBundleLoaderResult( event:ResourceBundleLoaderEvent ):void {
			//_logger.warn("we have bundle loader result");
			_resourceBundle = _providerStrategy.getResourceBundle( );			
			_resources.add( _locale.code, _resourceBundle );
			_notifyReady( );
		}
		
		/**
		 * TODO Find propper error handling strategy.
		 * @param	e
		 * @private
		 */
		public function onBundleLoaderError( event:ResourceBundleLoaderEvent ):void {
			
			//_logger.error(" LOAD ERROR: RESOURCE FILE NOT FOUND ");
			dispatchEvent( new LocalizationEvent( LocalizationEvent.UPDATE_ERROR, _locale ) );
			_locale = _oldLocale;
			_updateLangResources( );
		}
		
		/**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
		override public function toString( ):String { return "[ LocalizationManager]"; }
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// GETTERS & SETTERS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
		/**
		 * Returns an Array of supported ILocale's; Locale.ES, Locale.CA, Locale.EN.
		 */
		public function get supportedLocales( ):Array {
			var arr:Array = new Array();
			for( var locale:String in _localeSupport ) {
				arr.push( _localeSupport[ locale ] );
			}
			return arr.concat( );
		}
		
		/**
		 * Returns an Array of supported codes; es, ca, en.
		 * @return Array
		 */
		public function get supportedCodes( ):Array {
			var arr:Array = new Array();
			for( var locale:String in _localeSupport ) {
				arr.push( locale );
			}
			return arr.concat( );
		}
		
		/** @inheritDoc **/
		public function get currentBundle(  ):IResourceBundle { return _resourceBundle; }
		
		/** @inheritDoc **/
		public function get localeAvailable( ):Boolean { return _ready; }
		
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * Indicates whether the current <code class="prettyprint">ILocale</code> will be stored
		 * in a local shared object so that it can be restored the next time the application
		 * is started again.
		 *
		 * It will return the
		 * @default false
		 */
		public function get persistent( ): Boolean { return _persistent; }		
		/** @private */
		public function set persistent( save:Boolean ): void {
			_persistent = save;
			if( _locale ) _persistence.saveLocale( _locale );
		}
		
		/////////////////////////////////////////////////////////////////////////////////////
		
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PROTECTED METHODS.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		/**
		 *
		 * @private
		 */
		protected function _updateLangResources( ):void {
			if ( _resources.hasKey( _locale.code ) ) {
				_resourceBundle = _resources.get( _locale.code );
				_notifyReady( );
			} else {
				_ready = false;
				_providerStrategy.loadResourceBundle( _locale );
			}
		}		
		
		/**
		 * @private
		 */
		protected function _notifyReady( ):void {
			_ready = true;
			dispatchEvent( new LocalizationEvent( LocalizationEvent.UPDATE_AVAILABLE, _locale ) );
			
			if ( _persistent ) _persistence.saveLocale( _locale );
			//_logger.info("NOTIFY LANG LOADED! "  );
		}		
	}
}