module ApplicationHelper
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def get_stats
    first_day = Date.new(2013,8,30)
    result = {}

    for day in (first_day..Date.today) do
        result[day.strftime]=0
    end
    Book.all.each do |book|
        for day in (first_day..Date.today) do
            result[day.strftime]+=book.impressionist_count :start_date => day.beginning_of_day, :end_date => day.end_of_day
        end
    end
    result.to_a
  end
end