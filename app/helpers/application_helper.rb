module ApplicationHelper

  class ActionView::Helpers::FormBuilder
    def error_field()
      lis =''
      if self.object
        self.object.errors.full_messages.each do |msg|
          lis+= @template.content_tag 'li', msg
        end
      end
      @template.flash.now[:error] = @template.content_tag 'ul', lis.html_safe if lis.present?
      @template.show_flash_msg
    end
  end


  def show_flash_msg
    flash.each do |key, value|
      return content_tag 'div', value, class: flash_class(key)
    end
    nil
  end

  def flash_class(level)
    case level.to_s
      when 'success' then
        "alert alert-success"
      when 'error' then
        "alert alert-error"
      when 'alert' then
        "alert alert-error"
      else
        "alert alert-info"
    end
  end

end
