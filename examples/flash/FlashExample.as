package {
	
	import com.enjoymondays.i18n.core.ILocale;
	import com.enjoymondays.i18n.core.ILocalizationManager;
	import com.enjoymondays.i18n.core.IResourceBundleProviderFactory;
	import com.enjoymondays.i18n.core.IResourceBundleProviderManager;
	import com.enjoymondays.i18n.events.LocalizationEvent;
	import com.enjoymondays.i18n.Locale;
	import com.enjoymondays.i18n.LocalizationManager;
	import com.enjoymondays.i18n.providers.DefaultProviderFactory;
	import com.enjoymondays.i18n.providers.DefaultProviderManager;
	import com.enjoymondays.i18n.ResourceBundle;
	//import com.skinnygeek.logging.Logger;
	import flash.events.MouseEvent;
	
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Emiliano Burgos
	 */
	public class FlashExample extends Sprite {
		
		
		private var _localization				:ILocalizationManager;
		private var _provider					:IResourceBundleProviderManager;
		private var _factory					:IResourceBundleProviderFactory;
		
		//private var _logger						:Logger = Logger.instance( FlashExample );
		
		public function FlashExample():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);			
			
			_createUi( );
			
			_provider = new DefaultProviderManager;
			_factory  = new DefaultProviderFactory;
			
			_localization = LocalizationManager.instance;
			
			/*
			 * Get the curent locale and the locales supported by the application.
			 * Current locale is infered from url, or we use default from config.
			 * We could also get them from a service call.
			 */ 
			var currentLocale:ILocale = _getCurrentLocale( );
			var supportedCodes:Array  = _getSupportedCodes( );
			
			_localization = LocalizationManager.instance;
			_localization.setProviderStrategy( _provider, _factory );
			
			_localization.initialize( currentLocale, supportedCodes );
			
			/*
			 * Load the locale file for the current locale.
			 */
			_localization.addEventListener( LocalizationEvent.UPDATE_AVAILABLE, _onComplete );
		}
		
		
		
		private function _onComplete( e:LocalizationEvent ):void {		
			if ( ! _localization.currentBundle ) return;
			
			/*
			 * 
			 */ 
			if ( _localization.currentBundle.hasResource("helloWorld") ) {
				helloWorldText.htmlText = _localization.currentBundle.getResourceString( "helloWorld" );
			}
			
			/*
			 * 
			 */ 
			if ( _localization.currentBundle.hasBundle("texts") ) {
				messageText.htmlText = _localization.currentBundle.getBundle("texts").getResourceString("message1");
			}
			
		}
		
		/**
		 * 
		 * @return
		 */
		private function _getSupportedCodes( ):Array {
			return [Locale.ES, Locale.EN];
		}
		
		/**
		 * 
		 * @return
		 */
		private function _getCurrentLocale():ILocale {
			return Locale.ES;
		}
		
		private function _createUi( ):void {
			en.label.htmlText = "EN";
			es.label.htmlText = "ES";
			
			es.buttonMode = 
			en.buttonMode = true;
			
			es.mouseChildren = 
			en.mouseChildren = false;
			
			es.addEventListener(MouseEvent.CLICK, _selectLocale );
			en.addEventListener(MouseEvent.CLICK, _selectLocale );
		}
		
		private function _selectLocale(e:MouseEvent):void {
			
			var locale:ILocale = Locale.convert( e.target.name );
			trace( e.target.name, " selected locale is ", locale.variant );
			_localization.setCurrentLocale( locale );
		}
		
	}
	
}