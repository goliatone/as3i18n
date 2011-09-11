TODO
-----------------------------------

##### Add methods to merge resources from different sources. i.e:

- We load main locale file. A component such as a Image Gallery has its own
localization file, not loaded with Application file. We want to add its
resources to currentBundle so that we use the localization manager to handle updates and make it available to other UI components.

ADD HOOK EVENT TO MODIFY CURRENT RAW BUNDLE, SO THAT WE CAN APPEND DATA AND MERGE CONTENT FROM DIFFERENT SOURCES.
dispatch event BEFORE LocalizationEvent.UPDATE_AVAILABLE so that we can append additional data.
For instance, if we have a gallery module, and our images have descriptions available throught a data source internal to the
module, then we can catch that event, add our xml to the main bundle and make it available outside the gallery.

##### Add utility to manage bundles, so we can associate a bundle data with a delegate. i.e:
	_pageTextsXML = Localization.instance.currentBundle.getBundleParser( "bundleID",    ParserClassDefault );
	_pagesTextXML.getPage("info").getAttribute("title");
	_pagesTextXML.getPage("info").getAttribute("content");

##### Consider a way to update current locale internally without notifying it's update, an overwrite
- We might need it for Persistence.
- In YLM we had a splash screen that gave you the chance to select the locale, but if we overrode the currentLocale
we would exit the splash and go to first content sice the update event cascaded into the NavController et all.