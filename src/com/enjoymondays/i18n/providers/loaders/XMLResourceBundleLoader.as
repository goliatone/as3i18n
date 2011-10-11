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
package com.enjoymondays.i18n.providers.loaders {
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.i18n.ResourceBundleVO;
	import com.enjoymondays.i18n.core.IResourceBundleLoader;
	import com.enjoymondays.i18n.events.ResourceBundleLoaderEvent;
	
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;	
	import flash.events.IOErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.net.URLLoaderDataFormat;
	import flash.events.SecurityErrorEvent;
	


	/**
	 * <code class="prettyprint">XMLResourceBundleLoader</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 *  @version 	 1.0
	 */
	public class XMLResourceBundleLoader extends AbstractResourceBundleLoader {
		
		
		//private var _logger								:Logger = Logger.instance( XMLResourceBundleLoader );
		
		
		private var _xmlLoader							:URLLoader;
		private var _url								:String;
		
		/**
		 * <code class="prettyprint">XMLResourceBundleLoader</code>
		 * com.enjoymondays.i18n.providers.loaders.XMLResourceBundleLoader
		 */
		public function XMLResourceBundleLoader( ) {
			
		}
		
		/**
		 *
		 * @param	vo
		 * @see com.enjoymondays.i18n.providers.loaders.AbstractResourceBundleLoader#load()
		 */
		override public function load( vo:ResourceBundleVO ):void {
			_vo = vo;
			
			if ( _xmlLoader ) _deativateLoader( );
			
			_activateLoader( );			
			
			_xmlLoader.load( new URLRequest( _vo.url ) );
		}
		
		/**
		 * 
		 * @private
		 */
		protected function _handleLoader( e:Event = null ):void {
			switch( e.type ) {
				case Event.COMPLETE:
					
					_data = e.target.data as String;
					
					dispatchEvent( new ResourceBundleLoaderEvent( ResourceBundleLoaderEvent.LOADED, _data ) );
				break;
				
				case IOErrorEvent.IO_ERROR:
				case SecurityErrorEvent.SECURITY_ERROR:
					dispatchEvent( new ResourceBundleLoaderEvent( ResourceBundleLoaderEvent.ERROR, null ) );
				break;
			}
			
			_deativateLoader( );
			
		}
		
		/**
		 * 
		 * @private
		 */
		protected function _activateLoader(  ):void {
			_xmlLoader = new URLLoader;
			_xmlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			
			_xmlLoader.addEventListener( Event.COMPLETE, _handleLoader );
			_xmlLoader.addEventListener( IOErrorEvent.IO_ERROR, _handleLoader );
			_xmlLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, _handleLoader );
		}
		
		/**
		 * 
		 * @private
		 */
		protected function _deativateLoader( ):void {
			_xmlLoader.removeEventListener( Event.COMPLETE, _handleLoader );
			_xmlLoader.removeEventListener( IOErrorEvent.IO_ERROR, _handleLoader );
			_xmlLoader.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, _handleLoader );
		}
	}

}