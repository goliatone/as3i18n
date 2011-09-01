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
package com.enjoymondays.i18n.providers {
	
	import com.skinnygeek.logging.Logger;
	
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.i18n.core.ILocalizationManager;
	import com.enjoymondays.i18n.core.IResourceBundle;
	import com.enjoymondays.i18n.core.IResourceBundleParser;
	import com.enjoymondays.i18n.core.IResourceBundleLoader;
	import com.enjoymondays.i18n.core.IResourceBundleProvider;
	import com.enjoymondays.i18n.core.IResourceBundleProviderFactory;
	import com.enjoymondays.i18n.core.IResourceBundleProviderManager;
	
	
	import com.enjoymondays.i18n.ResourceBundleVO;
	import com.enjoymondays.i18n.events.ResourceBundleLoaderEvent;
	import com.enjoymondays.i18n.providers.strategy.AbstractProviderStrategy;
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	


	/**
	 * <code class="prettyprint">DefaultProviderManager</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class DefaultProviderManager extends EventDispatcher implements IResourceBundleProviderManager {
		
		private var _logger											:Logger = Logger.instance( DefaultProviderManager );
		
		/** @private **/
		protected var _owner										:ILocalizationManager;
		
		/** @private **/
		protected var _factory										:IResourceBundleProviderFactory;
		
		/** @private **/
		protected var _provider										:AbstractProviderStrategy;
		
		/** @private **/
		protected var _baseUrl										:String;
		
		/**
		 * <code class="prettyprint">DefaultProviderManager</code>
		 * com.enjoymondays.i18n.providers.DefaultProviderManager
		 */
		public function DefaultProviderManager( baseUrl:String = '' ) {
			_baseUrl = baseUrl;
		}
		
		/** @inheritDoc */
		public function setOwner( owner:ILocalizationManager ):void {
			_owner = owner;
		}
		
		/** @inheritDoc */
		public function setFactory( factory:IResourceBundleProviderFactory ):void {
			_factory = factory;
		}
		
		/** @inheritDoc */
		public function loadResourceBundle( locale:ILocale ):void {
			_provider = _factory.buildProvider( locale ) as AbstractProviderStrategy;
			
			var vo:ResourceBundleVO = _factory.buildBundleVO( locale, _baseUrl );
			
			_provider.addEventListener( ResourceBundleLoaderEvent.LOADED, _handleProvider );
			_provider.addEventListener( ResourceBundleLoaderEvent.ERROR, _handleProvider );
			
			_provider.load( vo );
		}
		
		/** @private */
		private function _handleProvider( e:ResourceBundleLoaderEvent ):void {
			
			_provider.removeEventListener( ResourceBundleLoaderEvent.LOADED, _handleProvider );
			_provider.removeEventListener( ResourceBundleLoaderEvent.ERROR, _handleProvider );
			
			switch( e.type ) {
				case ResourceBundleLoaderEvent.LOADED:
					_logger.warn("resource loaded: %0", e.data );
					_owner.onBundleLoaderResult( e );
				break;
				
				case ResourceBundleLoaderEvent.ERROR:
					_owner.onBundleLoaderError( e )
				break;
				
				if( hasEventListener( e.type ) ) dispatchEvent( e );
			}
		}
		
		
		/** @inheritDoc */
		public function getResourceBundle( parse:Boolean = false ):IResourceBundle {
			return _provider.parse( _provider.getRawdata( ) );
		}
		
		/** @inheritDoc */
		public function setBaseUrl( baseUrl:String ):void {
			_baseUrl = baseUrl;
		}
		
		
		
		
	}

}