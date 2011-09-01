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
package com.enjoymondays.i18n.providers.strategy {
	
	
	import com.enjoymondays.i18n.core.IResourceBundle;
	import com.enjoymondays.i18n.core.IResourceBundleLoader;
	import com.enjoymondays.i18n.core.IResourceBundleParser;
	import com.enjoymondays.i18n.core.IResourceBundleProvider;
	import com.enjoymondays.i18n.events.ResourceBundleLoaderEvent;
	import com.enjoymondays.i18n.ResourceBundleVO;
	import flash.events.EventDispatcher;
	


	/**
	 * <code class="prettyprint">AbstractProviderStrategy</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class AbstractProviderStrategy extends EventDispatcher implements IResourceBundleProvider, IResourceBundleParser, IResourceBundleLoader {
		
		/** @private **/
		protected var _loader										:IResourceBundleLoader;
		
		/** @private **/
		protected var _parser										:IResourceBundleParser;
		
		/** @private **/
		protected var _type											:String;
		
		/**
		 * <code class="prettyprint">AbstractProviderStrategy</code>
		 * com.enjoymondays.i18n.providers.strategy.AbstractProviderStrategy
		 * 
		 * @param	type
		 * @param	loader
		 * @param	parser
		 */
		public function AbstractProviderStrategy( type:String = null, loader:IResourceBundleLoader = null, parser:IResourceBundleParser = null ) {
			_type = type;
			_loader = loader;
			_parser = parser;
		}
		
		// implementation of IResourceBundleProvider
		/**
		 * 
		 * @return
		 */
		public function getType( ):String {
			return _type;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setLoader( loader:IResourceBundleLoader ):void {
			_loader = loader;
			_loader.addEventListener( ResourceBundleLoaderEvent.LOADED, _handleLoading );
			_loader.addEventListener( ResourceBundleLoaderEvent.ERROR, _handleLoading );
		}		
		
		/**
		 * @inheritDoc
		 */
		public function getLoader( ):IResourceBundleLoader {
			return _loader;
		}
		
		/**
		 * @inheritDoc
		 */
		public function setParser( parser:IResourceBundleParser ):void {
			_parser = parser;
		}
		
		/**
		 * @inheritDoc
		 */
		public function getParser( ):IResourceBundleParser {
			return _parser;
		}
		
		// implementation of IResourceBundleLoader
		
		/**
		 * @inheritDoc
		 */
		public function load( vo:ResourceBundleVO ):void {
			_loader.load( vo );
		}
		
		/**
		 * @inheritDoc
		 */
		public function getRawdata( ):* {
			return _loader.getRawdata( );
		}
		
		// implementation of IResourceBundleParser
		
		/**
		 * @inheritDoc
		 */
		public function parse( rawData:* ):IResourceBundle {
			return _parser.parse( rawData );
		}
		
		/**
		 * 
		 * @param	e
		 * @private
		 */
		protected function _handleLoading( e:ResourceBundleLoaderEvent ):void {
			_loader.removeEventListener( ResourceBundleLoaderEvent.LOADED, _handleLoading );
			_loader.removeEventListener( ResourceBundleLoaderEvent.ERROR, _handleLoading );
			dispatchEvent( e.clone( ) );
		}
	}

}