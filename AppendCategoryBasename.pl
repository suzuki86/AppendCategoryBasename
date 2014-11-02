package MT::Plugin::AppendCategoryBasename;

use base qw(MT::Plugin);

my $plugin = new MT::Plugin({
  id => 'appendcategorybasename',
  name => 'AppendCategoryBasename',
  description => 'AppendCategoryBasename',
  doc_link => 'http://codaholic.org/?p=600',
  version => '0.1.0',
  author_name => 'Toshinari Suzuki',
  author_link => 'http://suzuki.toshinari.jp/',
  registry => {
    callbacks => {
      'MT::App::CMS::template_source.list_category' => \&append_category_basename,
    },
  },
});
MT->add_plugin($plugin);

sub append_category_basename{
  my ($cb,$app,$tmpl) = @_;

  my $old = <<HTML;
                <th id="cat-categories" class="category"><mt:var name="object_label_plural"></th>
HTML
  $old = quotemeta($old);
  my $new = <<HTML;
                <th id="cat-categories" class="category"><mt:var name="object_label_plural"></th>
                <th style="width:100px;">ベースネーム</th>
HTML
  $$tmpl =~ s/$old/$new/;
  
  my $old = <<HTML;
                    <div style="margin-left: <mt:var name="category_pixel_depth">px;"><a href="<mt:var name="script_url">?__mode=view&amp;_type=<mt:var name="object_type" escape="url">&amp;blog_id=<mt:var name="blog_id" escape="url">&amp;id=<mt:var name="category_id" escape="url">"><mt:var name="category_label_full"></a></div>
                </td>
HTML
  $old = quotemeta($old);
  my $new = <<HTML;
                    <div style="margin-left: <mt:var name="category_pixel_depth">px;"><a href="<mt:var name="script_url">?__mode=view&amp;_type=<mt:var name="object_type" escape="url">&amp;blog_id=<mt:var name="blog_id" escape="url">&amp;id=<mt:var name="category_id" escape="url">"><mt:var name="category_label_full"></a></div>
                </td>
                <td>
                <mt:var name="category_basename">
                </td>
HTML
  $$tmpl =~ s/$old/$new/;
}

1;
