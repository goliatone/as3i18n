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
	
	import com.enjoymondays.i18n.events.ResourceBundleLoaderEvent;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * <code class="prettyprint">ILocalizationManager</code> interface.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public interface ILocalizationManager extends IEventDispatcher {
		
		/**
		 * During initialization we set the initial locale.
		 * If we have persistence enabled, we will try to load a previous locale.
		 * We provide an array of supported locales. We can pass string codes or Locale's instances.
		 *
		 * @param	locale
		 * @param	...supportedLocales
		 */
		function initialize( locale:ILocale = null, ...supportedLocales  ):void;
		
		/**
		 *
		 * @param	strategy	IResourceBundleProviderManager
		 * @param	factory		IResourceBundleProviderFactory
		 */
		function setProviderStrategy( strategy:IResourceBundleProviderManager, factory:IResourceBundleProviderFactory = null ):void;
		
		/**
		 *
		 * @return
		 * @see com.enjoymondays.i18n.core.IResourceBundleProviderManager;
		 */
		function getProviderStrategy( ):IResourceBundleProviderManager;
		
		
		/**
		 * We set the current value of the locale. This will first check if provided 
		 * locale is a valid value. 
		 * 
		 * Fires LocalizationEvent.UPDATE_REQUEST event.
		 * 
		 * @param	locale	ILocale instance.
		 * @return 	String Constant value representing a status code of a ILocalizationManager instance.
		 * @see 	com.enjoymondays.i18n.LocalizationStatus;
		 */
		function setCurrentLocale( locale:ILocale ):String;
		
		/**
		 * Returns the current ILocale value that corresponds with the
		 * active language of the application.
		 * 
		 * @return	ILocale instance that represents the currently active ILocale.
		 * @see com.enjoymondays.i18n.core.ILocale;
		 */
		function getCurrentLocale( ):ILocale;
		
		/**
		 * Returns the ILocalizedResource identified by provided key stored
		 * in current IResourceBundle.
		 * 
		 * @param	key	String value that id's a given IResourceBundle.
		 * @return	ILocalizedResource
		 * @see com.enjoymondays.i18n.core.ILocalizedResource;
		 */
		function getResource( key:String ):ILocalizedResource;
		
		/**
		 * Tells if current IResourceBundle has a resource identified by the 
		 * provided key string.
		 * 
		 * @param	key		String value that id's a given IResourceBundle.
		 * @return	Boolean	true if key relates to a IResourceBundle.
		 */
		function hasResource( key:String ):Boolean;
		
		/**
		 * Tells if a ResourceBundle has been loaded and stored. Notice that if
		 * a locale has not been selected, its resources are not loaded and also 
		 * they are not added to the resource list.
		 * 
		 * @param	id A two char string that corresponds with a Locale.CODE value.
		 * @return	true if id corresponds with a loaded bundle.
		 */
		function hasLocaleBundle( id:String ):Boolean;
		
		/**
		 * Returns a locale bundle that was previously loaded, identified
		 * by id.
		 * 
		 * @param	id A two char string that corresponds with a Locale.CODE value.
		 * @return	IResourceBundle instance corresponding to a given Locale.CODE
		 * 
		 * @see com.enjoymondays.i18n.core.IResourceBundle;
		 */
		function getLocaleBundle( id:String ):IResourceBundle;
		
		/**
		 * Returns the current stored bundle.
		 * 
		 * @see com.enjoymondays.i18n.core.IResourceBundle;
		 */
		function get currentBundle( ):IResourceBundle;
		
		/**
		 * When loading a new locale, this property is set to false
		 * and will only be setted to true after loaded. In case
		 * that the locale was previously loaded, it will be inmediatelly
		 * available after setting to new locale value.
		 */
		function get localeAvailable( ):Boolean;
		
		/**
		 *
		 * @param	loc Two char String code or Locale instance.
		 * @return	true if locale is in the supported locale data set.
		 * 
		 * @see 	com.enjoymondays.i18n.Locale#convert;
		 */
		function isSupportedLocale( loc:* ):Boolean;
		
		/**
		 *
		 * @param	loc  Two char String code or Locale instance
		 * @return
		 */
		function notSupportedLocale( loc:* ):Boolean;
		
		/**
		 * Set the supported locales, usually on initializing ILocalizationManager
		 * instance. 
		 * <p>Its a convinience method that calls multiple times <code>addSupportedLocale</code>
		 * We can pass any value that resolves to a valid ILocale instance.</p>
		 * 
		 * <listing>
		 * var locales:Array = [Locale.ES, Locale.CA, "en" ];
		 * LocalizationManager.instance.addSupporetedCodes( locales );
		 * //or
		 * LocalizationManager.instance.addSupporetedCodes( Locale.ES, Locale.CA, "en" );
		 * </listing>
		 * @param	...langs An array containing ILocale instances of supported languages.
		 */
		function addSupporetedCodes( ...langs ):void;
		
		
		/**
		 * We can pass a String or a ILocale. 
		 * <p>If we pass a String, it will be converted
		 * to a valid ILocale Object.</p>
		 * 
		 * @param	loc	Two char String code or Locale instance
		 */
		function addSupportedLocale( loc:* ):void ;
		
		/**
		 * Returns an Array of supported ILocale's.
		 * <p>All values are ILocale instances previoulsy defined in throguh addSupportedLocale calls.</p>
		 * <listing>
		 * var locales:Array = LocalizationManager.instance.supportedLocales( );
		 * trace("supported locales: ", locales ); 
		 * //supported locales:
		 * //[Locale => code: es, name: Spanish, variant: Español], 
		 * //[Locale => code: ca, name: Catalan, variant: Català],
		 * //[Locale => code: en, name: English, variant: English]
		 * </listing>
		 * 
		 */
		function get supportedLocales( ):Array;
		
		/**
		 * Returns an Array of supported codes.
		 * <p>All values are ILocale instances previoulsy defined in throguh addSupportedLocale calls.</p>
		 * <listing>
		 * var codes:Array = LocalizationManager.instance.supportedCodes( );
		 * trace("supported codes: ", codes ); //supported codes: es, ca, en.
		 * </listing>
		 * @return Array
		 */
		function get supportedCodes( ):Array;
		
		
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * Indicates whether the current <code class="prettyprint">ILocale</code> will be stored
		 * in a local shared object so that it can be restored the next time the application
		 * is started again.
		 *
		 * It will return the
		 * @default false
		 */
		function get persistent( ): Boolean;
		
		/** @private */
		function set persistent( save:Boolean ):void;
		
		/////////////////////////////////////////////////////////////////////////////////////
		// REVIEW Should we move this into a different interface? Or we should use events
		// instead of method callback?
		/////////////////////////////////////////////////////////////////////////////////////		
		
		/**
		 *
		 * @param	e
		 * @private
		 */
		function onBundleLoaderResult( event:ResourceBundleLoaderEvent ):void;
		
		/**
		 * TODO Find propper error handling strategy.
		 * @param	e
		 * @private
		 */
		function onBundleLoaderError( event:ResourceBundleLoaderEvent ):void;
	}
	
}