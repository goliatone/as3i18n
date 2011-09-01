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
package com.enjoymondays.i18n.providers.parsers {
	
	//import com.skinnygeek.logging.Logger;
	
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.utils.fixArguments;
	import com.enjoymondays.i18n.ResourceBundle;
	import com.enjoymondays.i18n.core.IResourceBundle;
	import com.enjoymondays.i18n.core.IResourceBundleParser;
	
	


	/**
	 * <code class="prettyprint">XMLResourceBundleParser</code>.
	 *
	 *	@langversion ActionScript 3.0
	 *	@Flash 		 Player 9.0.28.0
	 *	@author 	 Emiliano Burgos
	 *	@url		 http://www.enjoy-mondays.com
	 * @version 	 1.0
	 */
	public class XMLResourceBundleParser extends AbstractResourceBundleParser implements IResourceBundleParser {
		
		//private var _logger:Logger = Logger.instance( XMLResourceBundleParser );
		
		/**
		 * <code class="prettyprint">XMLResourceBundleParser</code>
		 * com.enjoymondays.i18n.providers.parsers.XMLResourceBundleParser
		 */
		public function XMLResourceBundleParser( id:String = null, locale:ILocale = null ) {
			super( id, locale );
		}
		
		/**
		 * 
		 * @inheritDoc
		 */
		override public function parse( rawData:* ):IResourceBundle {
			var bundle:IResourceBundle = new ResourceBundle( _id, _locale );
			var xml:XML = new XML( rawData );
			
			_buildBundle( bundle, xml );
			
			
			if ( xml.hasOwnProperty( 'bundle' ) ) {
				var child:IResourceBundle;
				for each( var node:XML in xml.bundle ) {
					child = new ResourceBundle( node.@id.toString( ), _locale );
					child.addRawData( node );
					_buildBundle( child, node );
					//_logger.fatal("we have bundle %0", node.@id.toString() );
					bundle.addBundle( child.id, child );
				}
			}
			return bundle;
		}
		
		/**
		 * 
		 * @param	bundle
		 * @param	xml
		 * @private
		 */
		protected function _buildBundle( bundle:IResourceBundle, xml:XML ):void {
			var data:Object;
			for each ( var node:XML in xml.copy ) {
				var attr:XMLList = node.attributes( );
				data = _getAttributes( attr,  "id" );
				bundle.buildResource( node.@id.toString(), node.toString(), data );
			}
		}
		
		/**
		 *	REVIEW Do we need this?! or we can simplify.
		 * @param	attributes
		 * @param	...exclude
		 * @return
		 * @private
		 */
		protected function _getAttributes( attributes:XMLList, ...exclude ):Object {
			
			if ( !attributes || attributes.length( ) == 0 ) return null;
			
			if ( exclude ) exclude = fixArguments( exclude );
			
			var data:Object = { };
			
			var name:String;
			var value:String;
			var included:Boolean = false;
			
			for each( var attribute:XML in attributes ) {
				name = attribute.name( );
				if ( exclude.indexOf( name ) != -1 ) continue;
				included = true;
				value = attribute.toString( );
				data[ name ] = value;
			}
			
			return included ? data: null;
		}
		
		
	}

}