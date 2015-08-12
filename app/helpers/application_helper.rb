module ApplicationHelper
  def is_chinese_locale?
    I18n.locale.eql?(:'zh-CN')
  end
end
