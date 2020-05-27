/**
 *	tyro Notes Script
 *
 *	Developed by Arlind Nushi - www.laborator.co
 */

var tyroNotes = tyroNotes || {};

;(function($, window, undefined)
{
	"use strict";
	
	$(document).ready(function()
	{
		tyroNotes.$container = $(".notes-env");
		
		$.extend(tyroNotes, {
			isPresent: tyroNotes.$container.length > 0,
			
			noTitleText: "Untitled",
			noDescriptionText: "(No content)",
			
			
			$currentNote: $(null),
			$currentNoteTitle: $(null),
			$currentNoteDescription: $(null),
			$currentNoteContent: $(null),
			
			addNote: function()
			{	
				var $note = $('<li><a href="#"><strong></strong><span></li></a></li>');
				
				$note.append('<div class="content"></div>').append('<button class="note-close">&times;</button>');
				
				$note.find('strong').html(tyroNotes.noTitleText);
				$note.find('span').html(tyroNotes.noDescriptionText);
				
				tyroNotes.$notesList.prepend($note);
				
				TweenMax.set($note, {autoAlpha: 0});
				
				var tl = new TimelineMax();
				
				tl.append( TweenMax.to($note, .10, {css: {autoAlpha: 1}}) );
				tl.append( TweenMax.to($note, .15, {css: {autoAlpha: .8}}) );
				tl.append( TweenMax.to($note, .15, {css: {autoAlpha: 1}}) );
				
				tyroNotes.$notesList.find('li').removeClass('current');
				$note.addClass('current');
				
				tyroNotes.$writePadTxt.focus();
				
				tyroNotes.checkCurrentNote();
			},
			
			checkCurrentNote: function()
			{
				var $current_note = tyroNotes.$notesList.find('li.current').first();
				
				if($current_note.length)
				{
					tyroNotes.$currentNote             = $current_note;
					tyroNotes.$currentNoteTitle        = $current_note.find('strong');
					tyroNotes.$currentNoteDescription  = $current_note.find('span');
					tyroNotes.$currentNoteContent      = $current_note.find('.content');
					
					tyroNotes.$writePadTxt.val( $.trim( tyroNotes.$currentNoteContent.html() ) ).trigger('autosize.resize');;
				}
				else
				{
					var first = tyroNotes.$notesList.find('li:first:not(.no-notes)');
					
					if(first.length)
					{
						first.addClass('current');
						tyroNotes.checkCurrentNote();
					}
					else
					{
						tyroNotes.$writePadTxt.val('');
						tyroNotes.$currentNote = $(null);
						tyroNotes.$currentNoteTitle = $(null);
						tyroNotes.$currentNoteDescription = $(null);
						tyroNotes.$currentNoteContent = $(null);
					}
				}
			},
			
			updateCurrentNoteText: function()
			{
				var text = $.trim( tyroNotes.$writePadTxt.val() );
					
				if(tyroNotes.$currentNote.length)
				{
					var title = '',
						description = '';
					
					if(text.length)
					{
						var _text = text.split("\n"), currline = 1;
						
						for(var i=0; i<_text.length; i++)
						{
							if(_text[i])
							{
								if(currline == 1)
								{
									title = _text[i];
								}
								else
								if(currline == 2)
								{
									description = _text[i];
								}
								
								currline++;
							}
							
							if(currline > 2)
								break;
						}
					}
					
					tyroNotes.$currentNoteTitle.text( title.length ? title : tyroNotes.noTitleText );
					tyroNotes.$currentNoteDescription.text( description.length ? description : tyroNotes.noDescriptionText );
					tyroNotes.$currentNoteContent.text( text );
				}
				else
				if(text.length)
				{
					tyroNotes.addNote();
				}
			}
		});
		
		// Mail Container Height fit with the document
		if(tyroNotes.isPresent)
		{
			tyroNotes.$notesList = tyroNotes.$container.find('.list-of-notes');
			tyroNotes.$writePad = tyroNotes.$container.find('.write-pad');
			tyroNotes.$writePadTxt = tyroNotes.$writePad.find('textarea');
			
			tyroNotes.$addNote = tyroNotes.$container.find('#add-note');
			
			tyroNotes.$addNote.on('click', function(ev)
			{
				tyroNotes.addNote();
			});
			
			tyroNotes.$writePadTxt.on('keyup', function(ev)
			{
				tyroNotes.updateCurrentNoteText();
			});
			
			tyroNotes.checkCurrentNote();
			
			tyroNotes.$notesList.on('click', 'li a', function(ev)
			{
				ev.preventDefault();
				
				tyroNotes.$notesList.find('li').removeClass('current');
				$(this).parent().addClass('current');
				
				tyroNotes.checkCurrentNote();
				
				
			});
			
			tyroNotes.$notesList.on('click', 'li .note-close', function(ev)
			{
				ev.preventDefault();
				
				var $note = $(this).parent();
				
				var tl = new TimelineMax();
				
				tl.append( 
					TweenMax.to($note, .15, {css: {autoAlpha: 0.2}, onComplete: function()
					{
						$note.slideUp('fast', function()
						{
							$note.remove();
							tyroNotes.checkCurrentNote();
						});
					}}) 
				);
			});
		}
	});
	
})(jQuery, window);

