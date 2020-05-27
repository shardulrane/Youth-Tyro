/**
 *	tyro Register Script
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */

var tyroRegister = tyroRegister || {};

;(function($, window, undefined)
{
	"use strict";
	
	$(document).ready(function()
	{
		tyroRegister.$container = $("#form_register");
		tyroRegister.$steps = tyroRegister.$container.find(".form-steps");
		tyroRegister.$steps_list = tyroRegister.$steps.find(".step");
		tyroRegister.step = 'step-1'; // current step
		
		
		tyroRegister.$container.validate({
			rules: {
				name: {
					required: true
				},
				
				email: {
					required: true,
					email: true
				},
				
				username: {
					required: true	
				},
				
				password: {
					required: true
				},
				
			},
			
			messages: {
				
				email: {
					email: 'Invalid E-mail.'
				}	
			},
			
			highlight: function(element){
				$(element).closest('.input-group').addClass('validate-has-error');
			},
			
			
			unhighlight: function(element)
			{
				$(element).closest('.input-group').removeClass('validate-has-error');
			},
			
			
		});
	
		// Steps Handler
		tyroRegister.$steps.find('[data-step]').on('click', function(ev)
		{
			ev.preventDefault();
			
			var $current_step = tyroRegister.$steps_list.filter('.current'),
				next_step = $(this).data('step'),
				validator = tyroRegister.$container.data('validator'),
				errors = 0;
			
			tyroRegister.$container.valid();
			errors = validator.numberOfInvalids();
			
			if(errors)
			{
				validator.focusInvalid();
			}
			else
			{
				var $next_step = tyroRegister.$steps_list.filter('#' + next_step),
					$other_steps = tyroRegister.$steps_list.not( $next_step ),
					
					current_step_height = $current_step.data('height'),
					next_step_height = $next_step.data('height');
				
				TweenMax.set(tyroRegister.$steps, {css: {height: current_step_height}});
				TweenMax.to(tyroRegister.$steps, 0.6, {css: {height: next_step_height}});
				
				TweenMax.to($current_step, .3, {css: {autoAlpha: 0}, onComplete: function()
				{
					$current_step.attr('style', '').removeClass('current');
					
					var $form_elements = $next_step.find('.form-group');
					
					TweenMax.set($form_elements, {css: {autoAlpha: 0}});
					$next_step.addClass('current');
					
					$form_elements.each(function(i, el)
					{
						var $form_element = $(el);
						
						TweenMax.to($form_element, .2, {css: {autoAlpha: 1}, delay: i * .09});
					});
					
					setTimeout(function()
					{
						$form_elements.add($next_step).add($next_step).attr('style', '');
						$form_elements.first().find('input').focus();
						
					}, 1000 * (.5 + ($form_elements.length - 1) * .09));
				}});
			}
		});
		
		tyroRegister.$steps_list.each(function(i, el)
		{
			var $this = $(el),
				is_current = $this.hasClass('current'),
				margin = 20;
			
			if(is_current)
			{
				$this.data('height', $this.outerHeight() + margin);
			}
			else
			{
				$this.addClass('current').data('height', $this.outerHeight() + margin).removeClass('current');
			}
		});
		
		
		// Login Form Setup
		tyroRegister.$body = $(".login-page");
		tyroRegister.$login_progressbar_indicator = $(".login-progressbar-indicator h3");
		tyroRegister.$login_progressbar = tyroRegister.$body.find(".login-progressbar div");
		
		tyroRegister.$login_progressbar_indicator.html('0%');
		
		if(tyroRegister.$body.hasClass('login-form-fall'))
		{
			var focus_set = false;
			
			setTimeout(function(){ 
				tyroRegister.$body.addClass('login-form-fall-init')
				
				setTimeout(function()
				{
					if( !focus_set)
					{
						tyroRegister.$container.find('input:first').focus();
						focus_set = true;
					}
					
				}, 550);
				
			}, 0);
		}
		else
		{
			tyroRegister.$container.find('input:first').focus();
		}
		
		
		// Functions
		$.extend(tyroRegister, {
			setPercentage: function(pct, callback)
			{
				pct = parseInt(pct / 100 * 100, 10) + '%';
				
				// Normal Login
				tyroRegister.$login_progressbar_indicator.html(pct);
				tyroRegister.$login_progressbar.width(pct);
				
				var o = {
					pct: parseInt(tyroRegister.$login_progressbar.width() / tyroRegister.$login_progressbar.parent().width() * 100, 10)
				};
				
				TweenMax.to(o, .7, {
					pct: parseInt(pct, 10),
					roundProps: ["pct"],
					ease: Sine.easeOut,
					onUpdate: function()
					{
						tyroRegister.$login_progressbar_indicator.html(o.pct + '%');
					},
					onComplete: callback
				});
			}
		});
	});
	
})(jQuery, window);