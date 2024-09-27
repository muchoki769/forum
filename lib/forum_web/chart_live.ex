defmodule ForumWeb.ChartLive do
  use ForumWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:points, [1,2,3,4,5])}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>TADA <canvas id="chart" phx-hook="ChartJS" data-points={Jason.encode!(@points)}></canvas>
     <div class="flex flex-row justify-center gap-4">
     <.button phx-click="change-data" phx-value-set="1">SET 1</.button>
     <.button phx-click="change-data" phx-value-set="2">SET 2</.button>
     <.button phx-click="change-data" phx-value-set="3">SET 3</.button>
     </div>
    </div>
    """
  end

  @impl true
  def handle_event("change-data", %{"set" => set}, socket) do
    dataset =
      case set do
        "1" -> [1,2,3,4,5]
        "2" ->  [10,2,5,3,4]
        "3" -> [5,4,3,2,1]
      end

    {:noreply,assign( socket, :points, dataset)}
  end
end
