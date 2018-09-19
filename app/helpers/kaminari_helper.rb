module KaminariHelper
  def pagination page, per, objects
    objects.page(page).per per
  end
end
