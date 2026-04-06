document.addEventListener("DOMContentLoaded", () => {
  let currentSort = "alphabeticOrder";
  let sortDirection = "asc";

  const shops = [...document.querySelectorAll(".availableShop")];
  const pagination = document.getElementById("shopNavNums");
  const btnNext = document.getElementById("shopNavRight");
  const btnPrev = document.getElementById("shopNavLeft");
  const searchInput = document.getElementById("selectedShopSearcher");
  const noMatchFigure = document.getElementById("noShopsMatched");

  const filterRating = document.getElementById("filterRating"); // e.g. >= 4
  const filterFree = document.getElementById("filterFree");
  const filterFast = document.getElementById("deliveryTime");
  const filterBtn = document.getElementById("filterShopsBtn");

  let filteredShops = [...shops];
  const perPage = 3;
  let currentPage = 1;

  // ---------------- Helper Functions ----------------

  function parseDeliveryPrice(text) {
    if (!text) return { isFree: false, price: null };
    const t = text.trim().toLowerCase();
    if (t.includes("مجاني") || t.includes("free")) return { isFree: true, price: 0 };
    const match = t.match(/(\d+[\.,]?\d*)/);
    if (match) return { isFree: parseFloat(match[1].replace(",", ".")) === 0, price: parseFloat(match[1].replace(",", ".")) };
    return { isFree: false, price: null };
  }

  function parseDeliveryTime(shop) {
    const timer = shop.querySelector(".timer");
    if (timer) return parseInt(timer.textContent.trim()) || 0;
    return 999; // default high value
  }

  function getShopName(shop) {
    return shop.querySelector(".availableShopName")?.textContent.trim().toLowerCase() || "";
  }

  function getMinPay(shop) {
    const text = shop.querySelector(".minPay")?.textContent || "";
    const num = parseFloat(text.match(/[\d.]+/)?.[0]);
    return isNaN(num) ? 0 : num;
  }

  function getRating(shop) {
    const stars = shop.querySelector(".shopRatingStars")?.textContent || "0";
    return parseFloat(stars) || 0;
  }

  // ---------------- Filtering ----------------

  function applyFilters() {
    const query = (searchInput?.value || "").trim().toLowerCase();

    filteredShops = shops.filter(shop => {
      const name = getShopName(shop);

      // 1️⃣ Search by name
      if (query && !name.includes(query)) return false;

      // 2️⃣ Rating filter
      if (filterRating?.checked && getRating(shop) < 4) return false;

      // 3️⃣ Free delivery filter
      const { isFree } = parseDeliveryPrice(shop.querySelector(".deliveryPaymentAmount")?.textContent);
      if (filterFree?.checked && !isFree) return false;

      // 4️⃣ Fast delivery filter
      const time = parseDeliveryTime(shop);
      if (filterFast?.checked && time > 30) return false;

      return true;
    });

    applySorting(); // sort filtered shops
    currentPage = 1;
    createPagination();
    showPage(currentPage);
  }

  // ---------------- Sorting ----------------

  function setActiveSort(sortId) {
  document.querySelectorAll(".filterCategory").forEach(el => el.classList.remove("active"));

  if (currentSort === sortId) {
    // Same sort clicked → toggle direction
    sortDirection = sortDirection === "asc" ? "desc" : "asc";
  } else {
    // New sort clicked → set default direction
    if (sortId === "ratingOrder") {
      sortDirection = "desc"; // rating always starts descending
    } else {
      sortDirection = "asc";  // others start ascending
    }
  }

  currentSort = sortId;
  document.getElementById(sortId).classList.add("active");
}

  function applySorting() {
    filteredShops.sort((a, b) => {
      switch (currentSort) {
        case "alphabeticOrder":
          return sortDirection === "asc"
            ? getShopName(a).localeCompare(getShopName(b), "ar")
            : getShopName(b).localeCompare(getShopName(a), "ar");
        case "minPayOrder":
          return sortDirection === "asc" ? getMinPay(a) - getMinPay(b) : getMinPay(b) - getMinPay(a);
        case "deliveryTimeOrder":
          return sortDirection === "asc" ? parseDeliveryTime(a) - parseDeliveryTime(b) : parseDeliveryTime(b) - parseDeliveryTime(a);
        case "deliveryFeeOrder":
  const feeA = parseDeliveryPrice(a.querySelector(".deliveryPaymentAmount")?.textContent).price ?? 9999;
  const feeB = parseDeliveryPrice(b.querySelector(".deliveryPaymentAmount")?.textContent).price ?? 9999;

  // Free delivery always comes first
  const isFreeA = parseDeliveryPrice(a.querySelector(".deliveryPaymentAmount")?.textContent).isFree;
  const isFreeB = parseDeliveryPrice(b.querySelector(".deliveryPaymentAmount")?.textContent).isFree;

  if (isFreeA && !isFreeB) return -1; // A free, B not → A first
  if (!isFreeA && isFreeB) return 1;  // B free, A not → B first

  // Otherwise, sort by price
  return sortDirection === "asc" ? feeA - feeB : feeB - feeA;

        case "ratingOrder":
          return sortDirection === "asc" ? getRating(a) - getRating(b) : getRating(b) - getRating(a);
        default:
          return 0;
      }
    });
  }

  function sortAndShow(sortId) {
    setActiveSort(sortId);
    applySorting();
    currentPage = 1;
    createPagination();
    showPage(currentPage);
  }

  // ---------------- Pagination ----------------
function showPage(page) {
  const start = (page - 1) * perPage;
  const end = start + perPage;

  // Clear parent container
  const parent = document.querySelector(".allAvailableShops");
  parent.innerHTML = "";

  // Append only the shops in filteredShops slice for this page
  filteredShops.slice(start, end).forEach(shop => parent.appendChild(shop));

  const totalPages = Math.ceil(filteredShops.length / perPage) || 1;
  btnPrev.style.display = page === 1 ? "none" : "inline-block";
  btnNext.style.display = page === totalPages ? "none" : "inline-block";
  noMatchFigure.style.display = filteredShops.length ? "none" : "block";
}

  function createPagination() {
    const totalPages = Math.ceil(filteredShops.length / perPage);
    pagination.innerHTML = "";
    if (totalPages <= 1) return;

    for (let i = 1; i <= totalPages; i++) {
      const btn = document.createElement("button");
      btn.textContent = i;
      btn.dataset.page = i;
      btn.classList.add("page-btn");
      if (i === currentPage) btn.classList.add("active");
      btn.onclick = () => {
        currentPage = i;
        createPagination();
        showPage(currentPage);
      };
      pagination.appendChild(btn);
    }
  }

  // ---------------- Event Listeners ----------------

  document.getElementById("alphabeticOrder").addEventListener("click", () => sortAndShow("alphabeticOrder"));
  document.getElementById("minPayOrder").addEventListener("click", () => sortAndShow("minPayOrder"));
  document.getElementById("deliveryTimeOrder").addEventListener("click", () => sortAndShow("deliveryTimeOrder"));
  document.getElementById("deliveryFeeOrder").addEventListener("click", () => sortAndShow("deliveryFeeOrder"));
  document.getElementById("ratingOrder").addEventListener("click", () => sortAndShow("ratingOrder"));

  searchInput?.addEventListener("input", applyFilters);
  filterBtn?.addEventListener("click", applyFilters);

  btnNext.onclick = () => {
    if (currentPage < Math.ceil(filteredShops.length / perPage)) {
      currentPage++;
      showPage(currentPage);
      createPagination();
    }
  };
  btnPrev.onclick = () => {
    if (currentPage > 1) {
      currentPage--;
      showPage(currentPage);
      createPagination();
    }
  };

  // ---------------- Init ----------------
  applyFilters(); // will filter + sort + show page 1
});
