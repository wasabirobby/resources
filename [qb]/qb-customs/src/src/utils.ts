import axios, { AxiosError } from "axios";

export interface Option {
  name: string;
  label: string;
  price: number;
  tabIdx: number;
}

export interface Tab {
  name: string;
  label: string;
  price: number;
  subCategories?: Tab[];
  options?: Option[];
}

export function axiosPost(name: string, body?: Object): any {
  const resp = axios({
    url: `https://qb-customs/${name}`,
    method: "post",
    data: body || {},
  });

  resp.catch((err: AxiosError) => {
    if (err) {
      if (axios.isAxiosError(err)) {
        console.error("axios error: " + err.message);
      } else {
        console.error("unknown error: " + err);
      }
    }
  });

  return resp;
}
