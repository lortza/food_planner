require "commonmarker"

module NotesHelper
  def render_markdown(text)
    # Commonmarker with GitHub Flavored Markdown extensions enabled by default
    html = Commonmarker.to_html(text, options: {
      parse: {
        smart: true  # Smart punctuation (optional)
      },
      render: {
        unsafe: false,  # Don't allow raw HTML
        escape: true,   # Escape HTML instead
        hardbreaks: true  # GitHub-style line breaks
      },
      extension: {
        strikethrough: true,
        table: true,
        autolink: true,
        tasklist: true,
        tagfilter: true
      }
    })

    # Wrap in a div with markdown class for styling
    content_tag(:div, html.html_safe, class: "markdown")
  end

  # TODO: make this method use link_to and point to favorite/unfavorite actions
  def toggle_favorite_status(note)
    if note.favorite?
      MaterialIcon.new(icon: :star, size: :xxlarge, title: "Unfavorite", filled: true, classes: "text-yellow-500").render
      # link_to MaterialIcon.new(icon: :star, size: :small, title: "Unfavorite", filled: true, classes: "text-yellow-500").render,
      #   unfavorite_note_path(note),
      #   method: :post,
      #   remote: true,
      #   title: "Unfavorite",
      #   data: {turbo_method: :post}
    else
      MaterialIcon.new(icon: :star, filled: false, size: :xxlarge, title: "Favorite").render
      # link_to MaterialIcon.new(icon: :star, filled: false, size: :small, title: "Favorite").render,
      #   favorite_note_path(note),
      #   method: :post,
      #   remote: true,
      #   title: "Favorite",
      #   data: {turbo_method: :post}
    end
  end
end
