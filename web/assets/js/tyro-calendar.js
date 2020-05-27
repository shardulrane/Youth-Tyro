/**
 *	tyro Calendar Script
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */

var tyroCalendar = tyroCalendar || {};

;(function($, window, undefined)
{
	"use strict";

	$(document).ready(function()
	{
		tyroCalendar.$container = $(".calendar-env");

		$.extend(tyroCalendar, {
			isPresent: tyroCalendar.$container.length > 0
		});

		// Mail Container Height fit with the document
		if(tyroCalendar.isPresent)
		{
			tyroCalendar.$sidebar = tyroCalendar.$container.find('.calendar-sidebar');
			tyroCalendar.$body = tyroCalendar.$container.find('.calendar-body');


			// Checkboxes
			var $cb = tyroCalendar.$body.find('table thead input[type="checkbox"], table tfoot input[type="checkbox"]');

			$cb.on('click', function()
			{
				$cb.attr('checked', this.checked).trigger('change');

				calendar_toggle_checkbox_status(this.checked);
			});

			// Highlight
			tyroCalendar.$body.find('table tbody input[type="checkbox"]').on('change', function()
			{
				$(this).closest('tr')[this.checked ? 'addClass' : 'removeClass']('highlight');
			});


			// Setup Calendar
			if($.isFunction($.fn.fullCalendar))
			{
				var calendar = $('#calendar');

				calendar.fullCalendar({
					header: {
						left: 'title',
						right: 'month,agendaWeek,agendaDay today prev,next'
					},

					//defaultView: 'basicWeek',

					editable: true,
					firstDay: 1,
					height: 600,
					droppable: true,
					drop: function(date, allDay) {

						var $this = $(this),
							eventObject = {
								title: $this.text(),
								start: date,
								allDay: allDay,
								className: $this.data('event-class')
							};

						calendar.fullCalendar('renderEvent', eventObject, true);

						$this.remove();
					}
				});

				$("#draggable_events li a").draggable({
					zIndex: 999,
					revert: true,
					revertDuration: 0
				}).on('click', function()
				{
					return false;
				});
			}
			else
			{
				alert("Please include full-calendar script!");
			}


			$("body").on('submit', '#add_event_form', function(ev)
			{
				ev.preventDefault();

				var text = $("#add_event_form input");

				if(text.val().length == 0)
					return false;

				var classes = ['', 'color-green', 'color-blue', 'color-orange', 'color-primary', ''],
					_class = classes[ Math.floor(classes.length * Math.random()) ],
					$event = $('<li><a href="#"></a></li>');

				$event.find('a').text(text.val()).addClass(_class).attr('data-event-class', _class);

				$event.appendTo($("#draggable_events"));

				$("#draggable_events li a").draggable({
					zIndex: 999,
					revert: true,
					revertDuration: 0
				}).on('click', function()
				{
					return false;
				});

				fit_calendar_container_height();

				$event.hide().slideDown('fast');
				text.val('');

				return false;
			});
		}
	});

})(jQuery, window);


function fit_calendar_container_height()
{
	if(tyroCalendar.isPresent)
	{
		if(tyroCalendar.$sidebar.height() < tyroCalendar.$body.height())
		{
			tyroCalendar.$sidebar.height( tyroCalendar.$body.height() );
		}
		else
		{
			var old_height = tyroCalendar.$sidebar.height();

			tyroCalendar.$sidebar.height('');

			if(tyroCalendar.$sidebar.height() < tyroCalendar.$body.height())
			{
				tyroCalendar.$sidebar.height(old_height);
			}
		}
	}
}

function reset_calendar_container_height()
{
	if(tyroCalendar.isPresent)
	{
		tyroCalendar.$sidebar.height('auto');
	}
}

function calendar_toggle_checkbox_status(checked)
{
	tyroCalendar.$body.find('table tbody input[type="checkbox"]' + (checked ? '' : ':checked')).attr('checked',  ! checked).click();
}