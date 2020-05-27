/**
 *	tyro Mail Script
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */

var tyroMail = tyroMail || {};

;(function($, window, undefined)
{
	"use strict";
	
	$(document).ready(function()
	{
		tyroMail.$container = $(".mail-env");
		
		$.extend(tyroMail, {
			isPresent: tyroMail.$container.length > 0
		});
		
		// Mail Container Height fit with the document
		if(tyroMail.isPresent)
		{
			tyroMail.$sidebar = tyroMail.$container.find('.mail-sidebar');
			tyroMail.$body = tyroMail.$container.find('.mail-body');
			
			
			// Checkboxes
			var $cb = tyroMail.$body.find('table thead input[type="checkbox"], table tfoot input[type="checkbox"]');
			
			$cb.on('click', function()
			{
				$cb.attr('checked', this.checked).trigger('change');
				
				mail_toggle_checkbox_status(this.checked);
			});
			
			// Highlight
			tyroMail.$body.find('table tbody input[type="checkbox"]').on('change', function()
			{
				$(this).closest('tr')[this.checked ? 'addClass' : 'removeClass']('highlight');
			});
		}
	});
	
})(jQuery, window);


function fit_mail_container_height()
{
	if(tyroMail.isPresent)
	{
		if(tyroMail.$sidebar.height() < tyroMail.$body.height())
		{
			tyroMail.$sidebar.height( tyroMail.$body.height() );
		}
		else
		{
			var old_height = tyroMail.$sidebar.height();
			
			tyroMail.$sidebar.height('');
			
			if(tyroMail.$sidebar.height() < tyroMail.$body.height())
			{
				tyroMail.$sidebar.height(old_height);
			}
		}
	}
}

function reset_mail_container_height()
{
	if(tyroMail.isPresent)
	{
		tyroMail.$sidebar.height('auto');
	}
}

function mail_toggle_checkbox_status(checked)
{	
	tyroMail.$body.find('table tbody input[type="checkbox"]' + (checked ? '' : ':checked')).attr('checked',  ! checked).click();
}