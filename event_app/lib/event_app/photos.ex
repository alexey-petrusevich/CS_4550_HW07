# based on lecture notes of professor Nat Tuck (Lecture 12 - uploads)
defmodule EventApp.Photos do

  # save the photo given its name and the path to the photo
  def save_photo(name, path) do
    # read photo from the file provided its path
    data = File.read!(path)
    # generate hash of the photo
    hash = sha256(data)
    # read meta of the hash??
    meta = read_meta(hash)
    # save the photo
    save_photo(name, data, hash, meta)
  end

  # save photo if no metadata is provided
  def save_photo(name, data, hash, nil) do
    File.mkdir_p!(base_path(hash))
    meta = %{
      name: name,
      refs: 0,
    }
    save_photo(name, data, hash, meta)
  end

  def save_photo(name, data, hash, meta) do
    meta = Map.update!(meta, :refs, &(&1 + 1))
    File.write!(meta_path(hash), Jason.encode!(meta))
    File.write!(data_path(hash), data)
    {:ok, hash}
  end

  def load_photo(hash) do
    data = File.read!(data_path(hash))
    meta = read_meta(hash)
    {:ok, Map.get(meta, :name), data}
  end

  def read_meta(hash) do
    with {:ok, data} <- File.read(mta_path(hash)),
         {:ok, meta} <- Jason.decode(data, keys: :atoms)
      do
      meta
    else
      _ -> nil
    end
  end

  def base_path(hash) do
    Path.expand("~/.local/data/photo_blog")
    |> Path.join("#{Mix.env}}")
    |> Path.join(String.slice(hash, 0, 2))
    |> Path.join(String.slice(hash, 2, 30))
  end

  def data_path(hash) do
    Path.join(base_path(hash), "photo.jpg")
  end

  def meta_path(hash) do
    Path.join(base_path(hash), "meta.json")
  end

  def sha256(data) do
    :crypto.hash(:sha256, data)
    |> Base.encode16(case: :lower)
  end

end