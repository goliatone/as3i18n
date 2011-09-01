package com.enjoymondays.utils {
	


	/**
	 * <code class="prettyprint">fixArguments</code>.
	 *
	 *	
	 * Utility to fix concatenated methods that take ...rest arguments.
	 * This allows us to provide an array instead of item by item.
	 *
	 * @param	parameters
	 * @return	Array
	 *
	 * @example Using the fixArguments:
	 * <listing>
	 *  argumentsFail( ["uno","dos","tres"] );
	 *  argumentsFixed( "uno","dos","tres" );
	 *  argumentsFixed( ["uno","dos","tres"] );
	 *
	 * private function argumentsFail( ...parameters ):void {
	 *    for each( var msg:String in parameters ) trace(msg);
	 * }
	 * private function argumentsFixed( ...parameters ):void {
	 * 	  parameters = fixArguments( parameters );
	 *    for each( var msg:String in parameters ) trace(msg);
	 * }
	 * </listing>
	 * 
	 * @langversion ActionScript 3.0
	 * @Flash 		 Player 9.0.28.0
	 * @author 	 Emiliano Burgos
	 * @url		 http://www.paginaswebflash.com
	 * @version 	 1.0
	 */
	public function fixArguments( parameters:Array ):Array {
		return (parameters.length == 1 && (parameters[0] is Array) ) ? (parameters[0] as Array) : parameters;
	}

}